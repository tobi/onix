# frozen_string_literal: true

require "bundler"
require "digest"
require "fileutils"
require "pathname"
require "uri"

module Gemset2Nix
  module Commands
    class Import
      def run(argv)
        @project = Project.new
        name_override = nil

        while argv.first&.start_with?("-")
          case argv.shift
          when "--name", "-n" then name_override = argv.shift
          when "--help", "-h"
            usage
            exit 0
          else
            $stderr.puts "Unknown option. Use --help."
            exit 1
          end
        end

        if argv.empty?
          usage
          exit 1
        end

        lockfile, project_name = resolve_lockfile(argv.first, name_override)
        $stderr.puts "Importing #{project_name} from #{lockfile}"

        gemfile = lockfile.sub(/Gemfile\.lock$/, "Gemfile")
        ENV["BUNDLE_GEMFILE"] = File.expand_path(gemfile) if File.exist?(gemfile)

        lf = Bundler::LockfileParser.new(File.read(lockfile))
        rubygem_specs, git_repos = classify_specs(lf)

        write_gemset(project_name, lf, rubygem_specs, git_repos)
        write_app_nix(project_name, rubygem_specs, git_repos)
        rebuild_apps_registry
        write_git_derivations(git_repos)
      end

      private

      def usage
        $stderr.puts <<~USAGE
          Usage: gemset2nix import [--name NAME] <project-or-path>

          Import a Ruby project's Gemfile.lock into gemset2nix.

          Accepts:
            project name    — searches well-known locations for Gemfile.lock
            path to file    — Gemfile, Gemfile.lock, or directory
            --name NAME     — override the project name
        USAGE
      end

      def resolve_lockfile(arg, name_override)
        if File.exist?(arg)
          path = File.expand_path(arg)
          if File.basename(path) == "Gemfile"
            lockfile = "#{path}.lock"
            abort "No Gemfile.lock found next to #{path}" unless File.exist?(lockfile)
          elsif File.basename(path) == "Gemfile.lock"
            lockfile = path
          elsif File.directory?(path)
            lockfile = File.join(path, "Gemfile.lock")
            abort "No Gemfile.lock in #{path}" unless File.exist?(lockfile)
          else
            abort "Expected Gemfile, Gemfile.lock, or a directory: #{path}"
          end
          project = name_override || File.basename(File.dirname(lockfile))
        else
          project = name_override || arg
          candidates = [
            File.join(@project.root, "..", arg, "Gemfile.lock"),
            File.expand_path("~/src/ruby-tests/#{arg}/Gemfile.lock"),
            File.expand_path("~/src/#{arg}/Gemfile.lock"),
          ]
          lockfile = candidates.find { |c| File.exist?(c) }
          abort "Cannot find Gemfile.lock for '#{arg}'.\nSearched:\n  #{candidates.join("\n  ")}" unless lockfile
        end
        [lockfile, project]
      end

      def classify_specs(lf)
        rubygem_specs = []
        git_specs = []

        lf.specs.each do |spec|
          src = spec.source
          case src
          when Bundler::Source::Git
            base = File.basename(src.uri, ".git")
            git_specs << { spec: spec, uri: src.uri, rev: src.revision,
                           base: base, shortrev: src.revision[0, 12] }
          when Bundler::Source::Path
            next
          else
            existing = rubygem_specs.find { |s| s.name == spec.name }
            if existing
              rubygem_specs.delete(existing) if spec.platform.to_s == "ruby"
              next unless spec.platform.to_s == "ruby"
            end
            rubygem_specs << spec
          end
        end

        # Group git specs by repo+rev
        git_repos = {}
        git_specs.each do |gs|
          key = "#{gs[:base]}-#{gs[:shortrev]}"
          unless git_repos[key]
            git_repos[key] = { uri: gs[:uri], rev: gs[:rev], base: gs[:base],
                               shortrev: gs[:shortrev], gems: [] }
          end
          git_repos[key][:gems] << gs[:spec] unless git_repos[key][:gems].any? { |e| e.name == gs[:spec].name }
        end

        $stderr.puts "  #{rubygem_specs.size} rubygems, #{git_specs.size} git (#{git_repos.size} repos)"
        [rubygem_specs, git_repos]
      end

      def write_gemset(project_name, lf, rubygem_specs, git_repos)
        by_name = {}
        lf.specs.each do |spec|
          source = spec.source
          next if source.is_a?(Bundler::Source::Path) && !source.is_a?(Bundler::Source::Git)
          prev = by_name[spec.name]
          if prev.nil? || (spec.platform.to_s != "ruby" && prev[:spec].platform.to_s == "ruby")
            by_name[spec.name] = { spec: spec, source: source }
          end
        end

        lines = by_name.values.sort_by { |e| e[:spec].name }.map do |entry|
          spec = entry[:spec]
          source = entry[:source]
          if source.is_a?(Bundler::Source::Git)
            "#{spec.name} #{spec.version} git:#{source.uri}@#{source.revision}"
          else
            "#{spec.name} #{spec.version}"
          end
        end

        FileUtils.mkdir_p(@project.imports_dir)
        File.write(File.join(@project.imports_dir, "#{project_name}.gemset"), lines.join("\n") + "\n")
        $stderr.puts "  -> imports/#{project_name}.gemset (#{by_name.size} gems)"
      end

      def write_app_nix(project_name, rubygem_specs, git_repos)
        nix = +""
        nix << NixWriter::BANNER_IMPORT
        nix << "# #{project_name.upcase} — #{rubygem_specs.size + git_repos.values.sum { |r| r[:gems].size }} gems\n"
        nix << "#\n"
        nix << "[\n"

        rubygem_specs.sort_by(&:name).each do |spec|
          nix << "  { name = #{spec.name.inspect}; version = #{spec.version.to_s.inspect}; }\n"
        end

        git_repos.each do |_, repo|
          nix << "  # git: #{repo[:base]} @ #{repo[:shortrev]}\n"
          nix << "  { name = #{repo[:base].inspect}; git.rev = #{repo[:shortrev].inspect}; }\n"
        end

        nix << "]\n"

        FileUtils.mkdir_p(@project.app_dir)
        File.write(File.join(@project.app_dir, "#{project_name}.nix"), nix)
        $stderr.puts "  -> nix/app/#{project_name}.nix"
      end

      def rebuild_apps_registry
        apps = +""
        apps << NixWriter::BANNER_IMPORT
        apps << "# App presets for gem.app.<name>.enable = true\n"
        apps << "#\n"
        apps << "{\n"
        Dir.glob(File.join(@project.app_dir, "*.nix")).sort.each do |f|
          name = File.basename(f, ".nix")
          apps << "  #{name.inspect} = import ../app/#{name}.nix;\n"
        end
        apps << "}\n"

        FileUtils.mkdir_p(@project.modules_dir)
        File.write(File.join(@project.modules_dir, "apps.nix"), apps)
        $stderr.puts "  -> nix/modules/apps.nix"
      end

      def write_git_derivations(git_repos)
        si = NixWriter::SH
        hd = NixWriter::HD

        git_repos.each do |repo_key, repo|
          source_dir = repo[:gems].lazy.map { |spec|
            File.join(@project.source_dir, "#{spec.name}-#{spec.version}")
          }.find { |d| Dir.exist?(d) }

          unless source_dir
            $stderr.puts "  WARN: no source for git repo #{repo_key}"
            next
          end

          git_dir = File.join(@project.output_dir, repo[:base], "git-#{repo[:shortrev]}")
          FileUtils.mkdir_p(git_dir)
          source_link = File.join(git_dir, "source")
          FileUtils.rm_f(source_link)
          FileUtils.ln_s(File.expand_path(source_dir), source_link)

          missing_gemspecs = repo[:gems].select do |spec|
            !File.exist?(File.join(source_dir, "#{spec.name}.gemspec")) &&
              !File.exist?(File.join(source_dir, spec.name, "#{spec.name}.gemspec"))
          end

          gnix = +""
          gnix << NixWriter::BANNER_IMPORT
          gnix << "# Git: #{repo[:base]} @ #{repo[:shortrev]}\n"
          gnix << "# URI: #{repo[:uri]}\n"
          gnix << "# Gems: #{repo[:gems].map(&:name).join(", ")}\n"
          gnix << "#\n"
          gnix << "{\n  lib,\n  stdenv,\n  ruby,\n}:\n"
          gnix << "let\n"
          gnix << "  rubyVersion = \"${ruby.version.majMin}.0\";\n"
          gnix << "  bundle_path = \"ruby/${rubyVersion}\";\n"
          gnix << "in\n"
          gnix << "stdenv.mkDerivation {\n"
          gnix << "  pname = #{repo[:base].inspect};\n"
          gnix << "  version = #{repo[:shortrev].inspect};\n"
          gnix << "  src = builtins.path {\n"
          gnix << "    path = ./source;\n"
          gnix << "    name = \"#{repo_key}-source\";\n"
          gnix << "  };\n\n"
          gnix << "  dontBuild = true;\n"
          gnix << "  dontConfigure = true;\n\n"
          gnix << "  passthru = { inherit bundle_path; };\n\n"
          gnix << "  installPhase = ''\n"
          gnix << "#{si}local dest=$out/${bundle_path}/bundler/gems/#{repo_key}\n"
          gnix << "#{si}mkdir -p $dest\n"
          gnix << "#{si}cp -r . $dest/\n"

          missing_gemspecs.each do |spec|
            gnix << "#{si}cat > $dest/#{spec.name}.gemspec <<'EOF'\n"
            gnix << "#{hd}Gem::Specification.new do |s|\n"
            gnix << "#{hd}  s.name = #{spec.name.inspect}\n"
            gnix << "#{hd}  s.version = #{spec.version.to_s.inspect}\n"
            gnix << "#{hd}  s.summary = #{spec.name.inspect}\n"
            gnix << "#{hd}  s.require_paths = [\"lib\"]\n"
            gnix << "#{hd}  s.files = []\n"
            gnix << "#{hd}end\n"
            gnix << "#{hd}EOF\n"
          end

          gnix << "  '';\n}\n"
          File.write(File.join(git_dir, "default.nix"), gnix)
          $stderr.puts "  -> nix/gem/#{repo[:base]}/git-#{repo[:shortrev]}/"

          patch_selector(repo)
        end
      end

      def patch_selector(repo)
        selector_path = File.join(@project.output_dir, repo[:base], "default.nix")

        if File.exist?(selector_path)
          selector = File.read(selector_path)
          rev_line = "    #{repo[:shortrev].inspect} = import ./git-#{repo[:shortrev]} { inherit lib stdenv ruby; };\n"
          unless selector.include?(repo[:shortrev].inspect)
            selector.sub!("  gitRevs = {\n", "  gitRevs = {\n#{rev_line}")
            File.write(selector_path, selector)
          end
        else
          write_git_only_selector(repo, selector_path)
        end
      end

      def write_git_only_selector(repo, path)
        sel = +""
        sel << NixWriter::BANNER
        sel << "# #{repo[:base]} (git only)\n#\n"
        sel << "{\n  lib,\n  stdenv,\n  ruby,\n"
        sel << "  pkgs ? null,\n  version ? null,\n  git ? { },\n}:\n"
        sel << "let\n  versions = { };\n\n  gitRevs = {\n"
        sel << "    #{repo[:shortrev].inspect} = import ./git-#{repo[:shortrev]} { inherit lib stdenv ruby; };\n"
        sel << "  };\nin\n"
        sel << "if git ? rev then\n"
        sel << "  gitRevs.\${git.rev}\n"
        sel << "    or (throw \"#{repo[:base]}: unknown git rev '\${git.rev}'\")\n"
        sel << "else if version != null then\n"
        sel << "  throw \"#{repo[:base]}: no rubygems versions, only git\"\n"
        sel << "else\n"
        sel << "  throw \"#{repo[:base]}: specify git.rev\"\n"

        FileUtils.mkdir_p(File.dirname(path))
        File.write(path, sel)

        # Add to top-level gem.nix
        top_path = File.join(@project.modules_dir, "gem.nix")
        if File.exist?(top_path)
          top = File.read(top_path, encoding: "UTF-8")
          entry = "  #{repo[:base].inspect} = args: gem #{repo[:base].inspect} args;\n"
          unless top.include?(entry)
            top.sub!(/^}\n\z/, "#{entry}}\n")
            File.write(top_path, top)
          end
        end
      end
    end
  end
end
