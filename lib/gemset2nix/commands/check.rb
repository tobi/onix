# frozen_string_literal: true

require "scint/lockfile/parser"
require "scint/source/git"
require "scint/source/path"
require "etc"
require "json"
require "open3"
require "tmpdir"

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

      def check_secrets
        gitleaks = find_gitleaks
        unless gitleaks
          return [true, "skipped — install gitleaks to enable (nix-shell -p gitleaks)"]
        end

        # Scan repo-owned files only (overlays, nix derivations) — not upstream gem sources.
        # Gem sources are third-party code full of test keys and crypto fixtures.
        scan_dirs = %w[overlays nix].filter_map do |d|
          dir = File.join(@project.root, d)
          Dir.exist?(dir) ? dir : nil
        end
        return [true, "no directories to scan"] if scan_dirs.empty?

        report = File.join(Dir.tmpdir, "gitleaks-#{$$}.json")
        all_findings = []

        scan_dirs.each do |dir|
          cmd = [gitleaks, "detect", "--source", dir,
                 "--no-git", "--report-format", "json", "--report-path", report,
                 "--exit-code", "0"]
          _out, status = Open3.capture2e(*cmd)

          unless status.success?
            return [false, "gitleaks failed to run on #{dir}"]
          end

          if File.exist?(report)
            results = JSON.parse(File.read(report))
            # Skip findings inside source/ symlinks (upstream gem code)
            results.reject! { |f| f["File"].include?("/source/") }
            all_findings.concat(results)
            File.delete(report) rescue nil
          end
        end

        if all_findings.empty?
          [true, "clean"]
        else
          [false, "#{all_findings.size} potential secrets found", all_findings.map { |f|
            "#{f["File"].sub(@project.root + "/", "")}:#{f["StartLine"]}: #{f["RuleID"]}"
          }]
        end
      end

      def find_gitleaks
        path = `which gitleaks 2>/dev/null`.strip
        path.empty? ? nil : path
      end

      # ── dep-completeness ─────────────────────────────────────────

      def check_dep_completeness
        gemset_files = Dir.glob(File.join(@project.gemsets_dir, "*.gemset"))
        return [true, "no gemsets"] if gemset_files.empty?

        missing = 0
        total = 0

        mat = @project.materializer
        gemset_files.each do |f|
          lockdata = @project.parse_lockfile(f)
          classified = mat.classify(lockdata)
          classified[:rubygems].each do |spec|
            total += 1
            dir = File.join(@project.output_dir, spec[:name], spec[:version])
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
