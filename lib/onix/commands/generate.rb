# frozen_string_literal: true

require "open3"
require "json"
require "fileutils"
require "thread"
require "uri"
require "cgi"
require "pathname"
require "scint/credentials"
require_relative "../packageset"
require_relative "../pnpm/credentials"
require_relative "../pnpm/node_inference"

module Onix
  module Commands
    # `onix generate` — reads JSONL packagesets, prefetches hashes, writes nix.
    #
    # Output:
    #   nix/ruby/<name>.nix   — per-gem: all known versions + sha256 hashes
    #   nix/node/<name>.nix   — per-node-package: all known versions
    #   nix/<project>.nix     — per-project: selects gem versions
    #   nix/build-gem.nix          — generic Ruby builder
    #   nix/build-node-modules.nix  — minimal node_modules builder
    #   nix/gem-config.nix         — overlay loader
    #
    class Generate
      def run(argv)
        @project = Project.new
        jobs = (ENV["JOBS"] || "20").to_i
        @script_policy_override = nil

        while argv.first&.start_with?("-")
          case argv.shift
          when "-j", "--jobs" then jobs = argv.shift.to_i
          when "--scripts"
            value = argv.shift
            abort "Invalid --scripts value #{value}" unless %w[none allowed].include?(value)
            @script_policy_override = value
          when "--help", "-h"
            $stderr.puts "Usage: onix generate [-j JOBS] [--scripts none|allowed]"
            exit 0
          end
        end

        packagesets = Dir.glob(File.join(@project.packagesets_dir, "*.jsonl"))
        if packagesets.empty?
          UI.fail "No packagesets found. Run 'onix import' first."
          exit 1
        end

        UI.header "Generate"

        # ── Load all packagesets ─────────────────────────────────────

        all_entries = {}   # "installer/name/version" => Entry
        projects = {}      # project_name => [Entry, ...]
        all_meta = {}      # project_name => Meta

        packagesets.each do |f|
          project_name = File.basename(f, ".jsonl")
          meta, entries = Packageset.read(f)
          all_meta[project_name] = meta
          projects[project_name] = entries

          entries.each do |e|
            next if e.source == "stdlib" || e.source == "path"
            key = "#{e.installer}/#{e.name}/#{e.version}"
            all_entries[key] ||= e
          end
        end

        # ── Load credentials for private gem sources ────────────────
        @credentials = Scint::Credentials.new
        # Register all unique remotes so credentials can be looked up
        all_entries.values.each do |e|
          next unless e.source == "rubygems" && e.remote
          @credentials.register_uri(e.remote)
        end

        rubygem_entries = all_entries.values.select { |e| e.installer != "node" && e.source == "rubygems" }
        git_entries = all_entries.values.select { |e| e.installer != "node" && e.source == "git" }
        node_entries = all_entries.values.select { |e| e.installer == "node" }
        UI.info "#{packagesets.size} packagesets, #{all_entries.size} unique packages " \
                "(#{rubygem_entries.size} rubygems, #{git_entries.size} git, #{node_entries.size} node)"

        # ── Resolve pnpm lockfile hashes ─────────────────────────

        node_hashes = {}
        node_lockfiles = {}
        projects.each do |name, entries|
          next unless entries.any? { |e| e.installer == "node" }

          hash = prefetch_pnpm_deps_hash(name, all_meta[name])
          node_lockfile = find_pnpm_lockfile(name)
          unless hash
            UI.fail "Unable to resolve pnpm lockfile hash for #{name}"
            exit 1
          end
          node_hashes[name] = hash
          node_lockfiles[name] = node_lockfile
          UI.info "resolved pnpm hash for #{name}: #{hash}"
        end

        # ── Load existing hashes ─────────────────────────────────────

        ruby_dir = File.join(@project.root, "nix", "ruby")
        existing = load_existing_hashes(ruby_dir)
        UI.info "#{existing.size} cached hashes" if existing.any?

        # ── Prefetch rubygems ────────────────────────────────────────

        new_hashes = {}
        if rubygem_entries.any?
          needed = rubygem_entries.reject { |e|
            key = "#{e.name}/#{e.version}"
            # Re-fetch if entry has platform but cached hash doesn't have platform metadata
            next false if e.platform && existing.key?(key) && !existing.key?("#{key}:platform")
            existing.key?(key)
          }
          cached = rubygem_entries.size - needed.size

          if needed.empty?
            UI.done "#{rubygem_entries.size} rubygems (all cached)"
          else
            progress = UI::Progress.new(rubygem_entries.size, label: "Prefetch")
            cached.times { progress.advance(skip: true) }
            errors = prefetch_rubygems(needed, jobs, new_hashes, progress)
            progress.finish
            if errors.any?
              errors.each { |e| UI.fail e }
              exit 1
            end
          end
        end

        # ── Prefetch git repos ───────────────────────────────────────

        git_repos = {}
        git_entries.each do |e|
          key = "#{e.uri}@#{e.rev}"
          git_repos[key] ||= { uri: e.uri, rev: e.rev, gems: [] }
          git_repos[key][:gems] << e
        end

        if git_repos.any?
          progress = UI::Progress.new(git_repos.size, label: "Prefetch git")
          git_repos.each_value do |repo|
            cache_key = "git:#{repo[:uri]}@#{repo[:rev]}"
            sha256 = existing[cache_key]
            unless sha256
              sha256 = nix_prefetch_git(repo[:uri], repo[:rev])
              unless sha256
                progress.finish
                UI.fail "Failed to prefetch #{repo[:uri]} @ #{repo[:rev]}"
                exit 1
              end
              new_hashes[cache_key] = sha256
            end
            repo[:sha256] = sha256 || existing[cache_key]
            progress.advance
          end
          progress.finish
        end

        # ── Build sha256 lookup ──────────────────────────────────────

        sha256_for = {}

        rubygem_entries.each do |e|
          key = "#{e.name}/#{e.version}"
          sha256_for[key] = existing[key] || new_hashes[key]
          # Carry platform metadata — only set when the source gem didn't exist
          # and the platform variant was fetched instead
          plat_key = "#{key}:platform"
          sha256_for[plat_key] = new_hashes[plat_key] || existing[plat_key]
        end

        git_repos.each_value do |repo|
          repo[:gems].each do |e|
            key = "#{e.name}/#{e.version}"
            sha256_for[key] = repo[:sha256]
          end
        end

        # ── Write nix/ruby/<name>.nix per gem ────────────────────────

        nix_dir = File.join(@project.root, "nix")
        FileUtils.mkdir_p(ruby_dir)

        ruby_by_name = {}
        node_by_name = {}
        all_entries.each_value do |e|
          if e.installer == "node"
            (node_by_name[e.name] ||= []) << e
          else
            (ruby_by_name[e.name] ||= []) << e
          end
        end

        ruby_by_name.each do |name, entries|
          write_gem_nix(ruby_dir, name, entries, sha256_for)
        end
        UI.wrote "nix/ruby/ (#{ruby_by_name.size} gems)"

        node_dir = File.join(@project.root, "nix", "node")
        FileUtils.mkdir_p(node_dir)
        node_by_name.each do |name, entries|
          write_node_nix(node_dir, name, entries)
        end
        UI.wrote "nix/node/ (#{node_by_name.size} packages)"

        # ── Write per-project nix ────────────────────────────────────

        projects.each do |name, entries|
          write_project_nix(nix_dir, name, entries, all_meta[name], node_hashes[name], node_lockfiles[name])
        end

        # ── Copy support files ───────────────────────────────────────

        copy_support_files(nix_dir)

        total_packages = all_entries.size
        UI.done "#{total_packages} packages, #{projects.size} projects"
      end

      private

      # ── Existing hash loader ─────────────────────────────────────

      def load_existing_hashes(ruby_dir)
        hashes = {}
        return hashes unless Dir.exist?(ruby_dir)

        Dir.glob(File.join(ruby_dir, "*.nix")).each do |f|
          name = File.basename(f, ".nix")
          content = File.read(f)
          # Match version blocks with sha256 (and optional platform)
          content.scan(/"([^"]+)"\s*=\s*\{[^}]*sha256\s*=\s*"([^"]+)"/) do |version, sha256|
            hashes["#{name}/#{version}"] = sha256
          end
          content.scan(/"([^"]+)"\s*=\s*\{[^}]*platform\s*=\s*"([^"]+)"/) do |version, platform|
            hashes["#{name}/#{version}:platform"] = platform
          end
          # Match git blocks
          content.scan(/url\s*=\s*"([^"]+)";\s*rev\s*=\s*"([^"]+)";\s*sha256\s*=\s*"([^"]+)"/) do |url, rev, sha256|
            hashes["git:#{url}@#{rev}"] = sha256
          end
        end
        hashes
      end

      # ── Parallel prefetch ──────────────────────────────────────

      def prefetch_rubygems(gems, jobs, hashes, progress)
        errors = []
        mutex = Mutex.new
        queue = Queue.new
        gems.each { |g| queue << g }
        jobs.times { queue << nil }

        threads = jobs.times.map do
          Thread.new do
            while (e = queue.pop)
              # Try source gem first (no platform suffix), fall back to platform variant
              source_url = "#{e.remote}/gems/#{e.name}-#{e.version}.gem"
              sha256 = nix_prefetch_url(inject_credentials(source_url))

              used_platform = nil
              if !sha256 && e.platform
                plat_url = "#{e.remote}/gems/#{e.name}-#{e.version}-#{e.platform}.gem"
                sha256 = nix_prefetch_url(inject_credentials(plat_url))
                used_platform = e.platform if sha256
              end

              key = "#{e.name}/#{e.version}"
              mutex.synchronize do
                if sha256
                  hashes[key] = sha256
                  # Track which gems needed platform fetch
                  hashes["#{key}:platform"] = used_platform if used_platform
                  progress.advance
                else
                  errors << "#{e.name} #{e.version}: failed to prefetch"
                  progress.advance(success: false)
                end
              end
            end
          end
        end
        threads.each(&:join)
        errors
      end

      # Embed HTTP Basic credentials into a URL for nix-prefetch-url.
      # The nix store indexes by content hash, so the URL with creds is only
      # used during prefetch — the generated nix files use the clean URL.
      def inject_credentials(url)
        creds = @credentials&.for_uri(url)
        return url unless creds

        parsed = URI.parse(url)
        parsed.user = CGI.escape(creds[0])
        parsed.password = CGI.escape(creds[1])
        parsed.to_s
      rescue URI::InvalidURIError
        url
      end

      def nix_prefetch_url(url)
        out, status = Open3.capture2("nix-prefetch-url", "--type", "sha256", url,
                                     err: File::NULL)
        status.success? ? out.strip : nil
      end

      def nix_prefetch_git(url, rev)
        out, status = Open3.capture2("nix-prefetch-git", "--url", url, "--rev", rev,
                                     "--quiet", err: File::NULL)
        return JSON.parse(out)["sha256"] if status.success?
        nil
      rescue Errno::ENOENT
        # nix-prefetch-git not on PATH — fall back to builtins.fetchGit
        nix_eval_fetchgit(url, rev)
      rescue
        nil
      end

      def nix_eval_fetchgit(url, rev)
        expr = "(builtins.fetchGit { url = \"#{url}\"; rev = \"#{rev}\"; }).narHash"
        out, status = Open3.capture2("nix", "eval", "--impure", "--raw", "--expr", expr,
                                     err: File::NULL)
        status.success? ? out.strip : nil
      rescue
        nil
      end

      def prefetch_pnpm_deps_hash(project_name, _meta)
        lockfile = find_pnpm_lockfile(project_name)
        return nil unless lockfile

        out, err, status = Open3.capture3(
          pnpm_prefetch_env(lockfile),
          "nix-build",
          "--impure",
          "--no-out-link",
          "--expr",
          prefetch_pnpm_deps_expr(lockfile),
        )

        hash = extract_pnpm_fetch_hash(out + err)
        return hash if hash

        return nil if status.success?

        status.success? ? hash : nil
      end

      def pnpm_prefetch_env(lockfile)
        token_lines = Pnpm::Credentials.token_lines(File.dirname(lockfile))
        env = {}
        env["ONIX_NPM_TOKEN_LINES"] = token_lines.join("\n") unless token_lines.empty?
        %w[SSL_CERT_FILE NODE_EXTRA_CA_CERTS].each do |name|
          value = ENV[name]
          env[name] = value unless value.nil? || value.empty?
        end
        env
      rescue StandardError
        {}
      end

      def prefetch_pnpm_deps_expr(lockfile)
        lockfile_dir = File.expand_path(File.dirname(lockfile))
        project_name = File.basename(lockfile_dir)
        <<~NIX
          let
            pkgs = import <nixpkgs> {};
          in
          pkgs.fetchPnpmDeps {
            pname = #{nix_str("onix-#{project_name}-pnpm-deps")};
            version = "0";
            src = #{nix_path(lockfile_dir)};
            pnpm = pkgs.pnpm;
            fetcherVersion = 3;
            hash = "";
            prePnpmInstall = ''
              #{pnpm_prefetch_npmrc_expr}
              pnpm config set package-import-method clone-or-copy
              pnpm config set side-effects-cache false
              pnpm config set update-notifier false
            '';
            pnpmInstallFlags = [ ];
            pnpmWorkspaces = [ ];
          }
        NIX
      end

      def pnpm_prefetch_npmrc_expr
        <<~EOF
          if [ -z "''${SSL_CERT_FILE:-}" ] || [ ! -f "''${SSL_CERT_FILE:-}" ]; then
            export SSL_CERT_FILE="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
          fi
          if [ -z "''${NODE_EXTRA_CA_CERTS:-}" ] || [ ! -f "''${NODE_EXTRA_CA_CERTS:-}" ]; then
            export NODE_EXTRA_CA_CERTS="$SSL_CERT_FILE"
          fi
          if [ -f "$SSL_CERT_FILE" ]; then
            export NPM_CONFIG_CAFILE="$SSL_CERT_FILE"
          fi
          if [ -n "$ONIX_NPM_TOKEN_LINES" ]; then
            printf '%s\\n' "$ONIX_NPM_TOKEN_LINES" > .npmrc
          fi
        EOF
      end

      def extract_pnpm_fetch_hash(output)
        output.scan(/got:\s*(sha256-[A-Za-z0-9+\/=]+)/).flatten.first
      end

      def find_pnpm_lockfile(project_name)
        return nil unless @project

        candidates = [
          File.join(@project.root, "pnpm-lock.yaml"),
          File.join(@project.root, "#{project_name}/pnpm-lock.yaml"),
          File.join(@project.root, "#{project_name}.pnpm-lock.yaml"),
        ].uniq

        candidates.find { |path| File.file?(path) }
      end

      def project_node_paths(pnpm_lockfile)
        default_root = "../."
        default_lockfile = "../pnpm-lock.yaml"
        return [default_root, default_lockfile] if pnpm_lockfile.nil? || pnpm_lockfile.empty?

        base = Pathname.new(@project.root).expand_path
        lock_path = Pathname.new(pnpm_lockfile).expand_path
        relative_project = lock_path.parent.relative_path_from(base).to_s
        relative_lockfile = lock_path.relative_path_from(base).to_s

        project_root = if relative_project == "."
          "../."
        else
          "../#{relative_project}/."
        end
        lockfile = "../#{relative_lockfile}"

        [project_root, lockfile]
      rescue StandardError
        [default_root, default_lockfile]
      end

      # ── Writers ────────────────────────────────────────────────

      def write_gem_nix(dir, name, entries, sha256_for)
        nix = +"# #{name} — generated by onix. Do not edit.\n{\n"

        sort_versions(entries).each do |e|
          sha256 = sha256_for["#{e.name}/#{e.version}"]
          nix << "  #{nix_str e.version} = {\n"
          nix << "    version = #{nix_str e.version};\n"

          if e.source == "git"
            nix << "    source = {\n"
            nix << "      type = \"git\";\n"
            nix << "      url = #{nix_str e.uri};\n"
            nix << "      rev = #{nix_str e.rev};\n"
            nix << "      sha256 = #{nix_str sha256};\n"
            nix << "      fetchSubmodules = #{e.submodules ? "true" : "false"};\n"
            nix << "    };\n"
            nix << "    subdir = #{nix_str e.subdir};\n" if e.subdir && e.subdir != "."
          else
            nix << "    source = {\n"
            nix << "      type = \"gem\";\n"
            nix << "      remotes = [ #{nix_str e.remote} ];\n"
            nix << "      sha256 = #{nix_str sha256};\n"
            nix << "    };\n"
            # Platform set when only prebuilt gem was available (no source .gem)
            used_platform = sha256_for["#{e.name}/#{e.version}:platform"]
            nix << "    platform = #{nix_str used_platform};\n" if used_platform
          end

          if e.require_paths && e.require_paths != ["lib"]
            nix << "    requirePaths = [ #{e.require_paths.map { |p| nix_str(p) }.join(" ")} ];\n"
          end
          if e.executables && !e.executables.empty?
            nix << "    executables = [ #{e.executables.map { |x| nix_str(x) }.join(" ")} ];\n"
          end

          nix << "  };\n"
        end

        nix << "}\n"
        File.write(File.join(dir, "#{name}.nix"), nix)
      end

      def write_project_nix(dir, project_name, entries, meta, pnpm_deps_hash, pnpm_lockfile)
        buildable = entries.reject { |e| e.source == "stdlib" || e.source == "path" }
        nodes = entries.select { |e| e.installer == "node" }
        ruby_nodes = buildable.reject { |e| e.installer == "node" }
        workspace_paths = nodes.select { |e| e.path }.map(&:path).uniq.sort
        project_root, lockfile = project_node_paths(pnpm_lockfile)

        nix = +"# #{project_name} — generated by onix. Do not edit.\n"
        nix << "{ pkgs ? import <nixpkgs> {}, ruby ? pkgs.ruby_3_4 }:\n"
        nix << "let\n"
        nix << "  buildGem = import ./build-gem.nix { inherit pkgs ruby; };\n"
        nix << "  buildGemByName = name:\n"
        nix << "    let\n"
        nix << "      versions = import (./ruby + \"/\${name}.nix\");\n"
        nix << "      version = builtins.head (builtins.attrNames versions);\n"
        nix << "      spec = versions.\${version};\n"
        nix << "    in buildGem (spec // { gemName = name; });\n"
        nix << "  gemConfig = import ./gem-config.nix {\n"
        nix << "    inherit pkgs ruby;\n"
        nix << "    overlayDir = ../overlays;\n"
        nix << "    rubyDir = ./ruby;\n"
        nix << "    buildGemFn = buildGemByName;\n"
        nix << "  };\n"
        nix << "  nodeConfig = import ./node-config.nix {\n"
        nix << "    inherit pkgs;\n"
        nix << "    overlayDir = ../overlays/node;\n"
        nix << "  };\n"
        nix << "\n"
        nix << "  build = name: version:\n"
        nix << "    let\n"
        nix << "      versions = import (./ruby + \"/\${name}.nix\");\n"
        nix << "      spec = versions.\${version};\n"
        nix << "      config = gemConfig.\${name} or {};\n"
        nix << "    in buildGem (spec // {\n"
        nix << "      gemName = name;\n"
        nix << "      nativeBuildInputs = config.deps or [];\n"
        nix << "      extconfFlags = config.extconfFlags or \"\";\n"
        nix << "      preBuild = config.preBuild or \"\";\n"
        nix << "      postBuild = config.postBuild or \"\";\n"
        nix << "    } // (if config ? buildPhase then { inherit (config) buildPhase; } else {})\n"
        nix << "      // (if config ? postInstall then { inherit (config) postInstall; } else {})\n"
        nix << "      // (if config ? skip then { inherit (config) skip; } else {})\n"
        nix << "      // (if config ? buildGems then { inherit (config) buildGems; } else {}));\n"
        nix << "\n"
        nix << "  gems = {\n"
        ruby_nodes.sort_by(&:name).each do |e|
          nix << "    #{nix_key(e.name)} = build #{nix_str e.name} #{nix_str e.version};\n"
        end
        nix << "  };\n"
        nix << "\n"
        nix << "  nodePackages = {\n"
        nodes.sort_by { |e| "#{e.name}/#{e.version}" }.each do |e|
          key = "#{e.name}/#{e.version}"
          nix << "    #{nix_key(key)} = {\n"
          nix << "      name = #{nix_str e.name};\n"
          nix << "      version = #{nix_str e.version};\n"
          nix << "      source = #{nix_str e.source};\n"
          nix << "      deps = [ #{(e.deps || []).map { |dep| nix_str(dep) }.join(" ")} ];\n"
          nix << "      groups = [ #{(e.groups || ['default']).map { |group| nix_str(group) }.join(" ")} ];\n"
          nix << "      path = #{nix_str e.path};\n" if e.path
          render_node_build_config(nix, node_inferred_config(e))
          nix << "    };\n"
        end
        nix << "  };\n"
        nix << "\n"
        if nodes.any?
          nix << "  nodeModules = pkgs.callPackage ./build-node-modules.nix {\n"
          nix << "    inherit nodePackages;\n"
          nix << "    inherit nodeConfig;\n"
          nix << "    project = #{nix_str project_name};\n"
          nix << "    projectRoot = #{nix_path(project_root)};\n"
          nix << "    lockfile = #{nix_path(lockfile)};\n"
          nix << "    packageManager = #{nix_value(meta.package_manager)};\n"
          nix << "    scriptPolicy = #{nix_str(resolve_node_script_policy(meta))};\n"
          nix << "    pnpmDepsHash = #{nix_str(pnpm_deps_hash)};\n"
          nix << "    workspacePaths = [ #{workspace_paths.map { |path| nix_str(path) }.join(" ")} ];\n" unless workspace_paths.empty?
          nix << "  };\n"
        end
        nix << "\n"
        nix << "  bundlePath = pkgs.buildEnv {\n"
        nix << "    name = #{nix_str "#{project_name}-bundle"};\n"
        nix << "    paths = builtins.attrValues gems;\n"
        nix << "  };\n"
        nix << "in gems // {\n"
        nix << "  inherit bundlePath;\n"
        nix << "  inherit nodeModules;\n" if nodes.any?
        nix << "  devShell = { buildInputs ? [], shellHook ? \"\", ... }@args:\n"
        nix << "    pkgs.mkShell (builtins.removeAttrs args [\"buildInputs\" \"shellHook\"] // {\n"
        nix << "      name = #{nix_str "#{project_name}-devshell"};\n"
        nix << "      buildInputs = [ ruby ] ++ buildInputs;\n"
        nix << "      shellHook = ''\n"
        nix << "        export BUNDLE_PATH=\"${bundlePath}\"\n"
        nix << "        export BUNDLE_GEMFILE=\"''${BUNDLE_GEMFILE:-$PWD/Gemfile}\"\n"
        nix << "        export GEM_PATH=\"${bundlePath}/${ruby.gemPath}''${GEM_PATH:+:$GEM_PATH}\"\n"
        nix << "      '' + shellHook;\n"
        nix << "    });\n"
        nix << "}\n"

        File.write(File.join(dir, "#{project_name}.nix"), nix)
        UI.wrote "nix/#{project_name}.nix"
      end

      def write_node_nix(dir, name, entries)
        nix = +"# #{name} — generated by onix. Do not edit.\n{\n"

        sort_versions(entries).each do |e|
          nix << "  #{nix_str e.version} = {\n"
          nix << "    version = #{nix_str e.version};\n"
          nix << "    source = #{nix_str e.source};\n"
          nix << "    deps = [ #{(e.deps || []).map { |dep| nix_str(dep) }.join(" ")} ];\n"
          nix << "    groups = [ #{(e.groups || ['default']).map { |group| nix_str(group) }.join(" ")} ];\n"
          nix << "    path = #{nix_str e.path};\n" if e.path
          nix << "  };\n"
        end

        nix << "}\n"
        path = File.join(dir, "#{name}.nix")
        FileUtils.mkdir_p(File.dirname(path))
        File.write(path, nix)
      end

      def copy_support_files(dir)
        data_dir = File.expand_path("../data", __dir__)
        %w[build-gem.nix build-node-modules.nix gem-config.nix node-config.nix].each do |f|
          FileUtils.cp(File.join(data_dir, f), File.join(dir, f))
        end
        UI.wrote "nix/build-gem.nix, nix/build-node-modules.nix, nix/gem-config.nix, nix/node-config.nix"
      end

      def render_node_build_config(nix, config)
        return if config.nil? || config.empty?

        nix << "      buildConfig = {\n"
        if (deps = config[:deps])
          nix << "        deps = [ #{deps.map { |name| nix_pkg_ref(name) }.join(" ")} ];\n"
        end

        if (pre_install = config[:pre_install])
          nix << "        preInstall = ''\n"
          nix << "          #{pre_install}\n"
          nix << "        '';\n"
        end

        if (pre_pnpm_install = config[:pre_pnpm_install])
          nix << "        prePnpmInstall = ''\n"
          nix << "          #{pre_pnpm_install}\n"
          nix << "        '';\n"
        end

        if (flags = config[:pnpm_install_flags])
          nix << "        pnpmInstallFlags = [ #{flags.map { |f| nix_str(f) }.join(" ")} ];\n"
        end

        nix << "      };\n"
      end

      def nix_pkg_ref(name)
        safe = name.to_s
        return "pkgs.#{safe}" if safe.match?(/\A[a-zA-Z_][a-zA-Z0-9_]*\z/)
        %{pkgs."#{safe}"}
      end

      def node_inferred_config(entry)
        config = Pnpm::NodeInference.config_for(entry)
        return nil if config.nil? || config.empty?

        config
      end

      def nix_key(name)
        name =~ /^[a-zA-Z_][a-zA-Z0-9_]*$/ ? name : "\"#{name}\""
      end

      def nix_path(path)
        return "null" if path.nil?
        return path if path =~ %r{\A(/|\.{1,2}/)}
        nix_str(path)
      end

      def nix_value(value)
        value.nil? ? "null" : nix_str(value)
      end

      def nix_str(s)
        "\"#{s}\""
      end

      def resolve_node_script_policy(meta)
        candidate = @script_policy_override || meta.script_policy || "none"
        return "none" if candidate == "none"
        return "allowed" if candidate == "allowed"
        return "allowed" if candidate == "all"

        UI.warn "Unsupported script policy #{candidate.inspect}; defaulting to allowed"
        "allowed"
      end

      def sort_versions(entries)
        entries.sort_by { |e| version_sort_key(e.version.to_s) }
      end

      def version_sort_key(version)
        parsed = parse_semver(version)
        return [0, parsed] if parsed

        [1, version.to_s]
      end

      def parse_semver(value)
        Gem::Version.new(value)
      rescue StandardError
        nil
      end
    end
  end
end
