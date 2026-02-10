# frozen_string_literal: true

require "bundler"
require "etc"
require "json"
require "open3"

module Gemset2Nix
  module Commands
    class Check
      CHECKS = %i[
        symlinks
        nix_eval
        source_clean
        secrets
        dep_completeness
        require_paths_vs_metadata
      ].freeze

      def run(argv)
        @project = Project.new

        while argv.first&.start_with?("-")
          case argv.shift
          when "--help", "-h"
            $stderr.puts "Usage: gemset2nix check [checks...]"
            $stderr.puts "\nChecks: #{CHECKS.map { |c| c.to_s.tr("_", "-") }.join(", ")}"
            $stderr.puts "Default: all"
            exit 0
          end
        end

        checks = if argv.empty?
          CHECKS
        else
          argv.map { |a| a.tr("-", "_").to_sym }
        end

        UI.header "Check"

        results = {}
        total_t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)

        # Run independent checks in parallel
        threads = checks.map do |check|
          Thread.new(check) do |c|
            t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
            begin
              ok, message = send(:"check_#{c}")
              elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0
              results[c] = { ok: ok, message: message, time: elapsed }
            rescue => e
              elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0
              results[c] = { ok: false, message: "ERROR: #{e.message}", time: elapsed }
            end
          end
        end

        threads.each(&:join)

        # Print results in order
        passed = 0
        failed = 0

        checks.each do |check|
          r = results[check]
          name = check.to_s.tr("_", "-")
          time = UI.dim(UI.format_time(r[:time]).rjust(7))
          if r[:ok]
            $stderr.puts "  #{UI.green("✓")} #{name.ljust(28)} #{time}  #{r[:message]}"
            passed += 1
          else
            $stderr.puts "  #{UI.red("✗")} #{name.ljust(28)} #{time}  #{r[:message]}"
            failed += 1
          end
        end

        total_time = UI.format_time(Process.clock_gettime(Process::CLOCK_MONOTONIC) - total_t0)
        UI.summary(
          "#{passed} passed",
          failed > 0 ? UI.red("#{failed} failed") : "0 failed",
          UI.dim(total_time)
        )
        exit 1 if failed > 0
      end

      private

      # ── symlinks ──────────────────────────────────────────────────

      def check_symlinks
        nix_dir = File.join(@project.root, "nix")
        return [true, "no nix/ dir"] unless Dir.exist?(nix_dir)

        total = 0
        bad = 0

        output, = Open3.capture2("find", nix_dir, "-type", "l", "-printf", "%p\t%l\n")
        output.each_line do |line|
          total += 1
          _path, target = line.strip.split("\t", 2)
          bad += 1 if target&.include?("/..")
        end

        # Self-referencing in cache
        source_dir = @project.source_dir
        if Dir.exist?(source_dir)
          Dir.each_child(source_dir) do |parent|
            parent_path = File.join(source_dir, parent)
            next unless File.directory?(parent_path)
            child = File.join(parent_path, parent)
            bad += 1 if File.exist?(child)
          end
        end

        if bad > 0
          [false, "#{bad} problems out of #{total} symlinks"]
        else
          [true, "#{total} symlinks clean"]
        end
      end

      # ── nix-eval ─────────────────────────────────────────────────

      def check_nix_eval
        files = Dir.glob(File.join(@project.output_dir, "*", "*", "default.nix")) +
                Dir.glob(File.join(@project.output_dir, "*", "default.nix")) +
                Dir.glob(File.join(@project.root, "nix", "**", "*.nix")) +
                Dir.glob(File.join(@project.overlays_dir, "*.nix"))
        files.uniq!

        errors = 0
        mutex = Mutex.new
        cpus = Etc.nprocessors

        files.each_slice((files.size / cpus).clamp(1, 200)).map do |batch|
          Thread.new do
            batch.each do |f|
              _, _, status = Open3.capture3("nix-instantiate", "--parse", f)
              mutex.synchronize { errors += 1 } unless status.success?
            end
          end
        end.each(&:join)

        if errors > 0
          [false, "#{errors}/#{files.size} files failed to parse"]
        else
          [true, "#{files.size} nix files parse OK"]
        end
      end

      # ── source-clean ─────────────────────────────────────────────

      def check_source_clean
        ext_dirs = Dir.glob(File.join(@project.output_dir, "*", "*", "source", "ext"))
        leaked = []
        mutex = Mutex.new

        ext_dirs.each_slice(100).flat_map do |batch|
          batch.map do |ext_dir|
            Thread.new do
              source = File.dirname(ext_dir)
              Dir.glob(File.join(source, "lib", "**", "*.{so,bundle}")).each do |f|
                mutex.synchronize { leaked << f.sub(@project.root + "/", "") }
              end
            end
          end
        end.each(&:join)

        if leaked.empty?
          [true, "no leaked .so files"]
        else
          [false, "#{leaked.size} leaked .so files: #{leaked.first(3).join(", ")}"]
        end
      end

      # ── secrets ──────────────────────────────────────────────────

      SECRETS_PATTERNS = {
        "Private key" => /-----BEGIN (RSA |DSA |EC |OPENSSH )?PRIVATE KEY-----/,
        "AWS key" => /(?<![A-Z0-9])AKIA[0-9A-Z]{16}(?![A-Z0-9])/,
        "GitHub token" => /(?:ghp|gho|ghu|ghs|ghr)_[A-Za-z0-9_]{36,}/,
        "GitLab token" => /glpat-[A-Za-z0-9\-_]{20,}/,
        "Slack webhook" => %r{https://hooks\.slack\.com/services/T[A-Z0-9]+/B[A-Z0-9]+/[A-Za-z0-9]+},
        "Password in URL" => %r{://[^/\s]+:[^@/\s]{8,}@[^/\s]+},
      }.freeze

      SECRETS_PATH_SKIP = %r{/spec/fixtures/|/test/fixtures/|/node_modules/|/ext/openssl/|README\.md$|CHANGELOG\.md$|tests/lint/}

      SECRETS_CONTENT_SKIP = /EXAMPLE|example\.com|placeholder|changeme|xxxx|your[_-]?secret/i

      def check_secrets
        findings = 0

        # Scan repo files
        %w[lib exe overlays].each do |d|
          dir = File.join(@project.root, d)
          next unless Dir.exist?(dir)
          findings += scan_secrets_dir(dir)
        end

        # Scan gem sources (threaded)
        source_dirs = Dir.glob(File.join(@project.output_dir, "*", "*", "source"))
        mutex = Mutex.new
        source_dirs.each_slice(50).flat_map do |batch|
          batch.map do |d|
            Thread.new do
              next unless Dir.exist?(d)
              n = scan_secrets_dir(d, gem_source: true)
              mutex.synchronize { findings += n }
            end
          end
        end.each(&:join)

        if findings > 0
          [false, "#{findings} potential secrets found"]
        else
          gem_count = source_dirs.count { |d| Dir.exist?(d) }
          [true, "repo + #{gem_count} gem sources clean"]
        end
      end

      def scan_secrets_dir(dir, gem_source: false)
        findings = 0
        Dir.glob(File.join(dir, "**", "*")).each do |path|
          next unless File.file?(path)
          next if File.size(path) > 1_048_576
          next if path.include?("/.git/")
          rel = path.sub(@project.root + "/", "")
          next if gem_source && SECRETS_PATH_SKIP.match?(rel)

          begin
            content = File.binread(path)
          rescue
            next
          end
          next if content[0..512]&.include?("\x00")
          content.force_encoding("UTF-8")
          content.encode!("UTF-8", invalid: :replace, undef: :replace, replace: "")

          content.each_line do |line|
            SECRETS_PATTERNS.each do |_, re|
              next unless re.match?(line)
              next if gem_source && SECRETS_CONTENT_SKIP.match?(line)
              findings += 1
            end
          end
        end
        findings
      end

      # ── dep-completeness ─────────────────────────────────────────

      def check_dep_completeness
        gemset_files = Dir.glob(File.join(@project.gemsets_dir, "*.gemset"))
        return [true, "no gemsets"] if gemset_files.empty?

        missing = 0
        total = 0

        gemset_files.each do |f|
          lf = @project.parse_lockfile(f)
          lf.specs.each do |spec|
            src = spec.source
            next if src.is_a?(Bundler::Source::Git)
            next if src.is_a?(Bundler::Source::Path)
            total += 1
            dir = File.join(@project.output_dir, spec.name, spec.version.to_s)
            missing += 1 unless Dir.exist?(dir)
          end
        end

        if missing > 0
          [false, "#{missing}/#{total} gems missing derivations"]
        else
          [true, "#{total} gems all have derivations"]
        end
      end

      # ── require-paths-vs-metadata ────────────────────────────────

      def check_require_paths_vs_metadata
        meta_dir = @project.meta_dir
        return [true, "no metadata"] unless Dir.exist?(meta_dir)

        mismatches = 0
        checked = 0

        Dir.glob(File.join(meta_dir, "*.json")).each do |f|
          meta = JSON.parse(File.read(f))
          name = meta["name"]
          version = meta["version"]
          meta_paths = (meta["require_paths"] || ["lib"]).reject { |p| p.start_with?("/") }.sort

          nix_file = File.join(@project.output_dir, name, version, "default.nix")
          next unless File.exist?(nix_file)

          content = File.read(nix_file, encoding: "UTF-8")
          if content =~ /s\.require_paths\s*=\s*\[([^\]]+)\]/
            nix_paths = $1.scan(/"([^"]+)"/).flatten.reject { |p| p.start_with?("/") }.sort
            mismatches += 1 if nix_paths != meta_paths
          end
          checked += 1
        end

        if mismatches > 0
          [false, "#{mismatches}/#{checked} require_paths mismatches"]
        else
          [true, "#{checked} require_paths match"]
        end
      end
    end
  end
end
