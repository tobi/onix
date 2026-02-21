# frozen_string_literal: true

require "etc"
require "json"
require "open3"
require "tmpdir"
require "set"
require_relative "../packageset"

module Onix
  module Commands
    class Check
      CHECKS = %i[
        nix_eval
        packageset_complete
        packageset_metadata
        secrets
      ].freeze

      def run(argv)
        @project = Project.new

        while argv.first&.start_with?("-")
          case argv.shift
          when "--help", "-h"
            $stderr.puts "Usage: onix check [checks...]"
            $stderr.puts "\nChecks: #{CHECKS.map { |c| c.to_s.tr("_", "-") }.join(", ")}"
            exit 0
          end
        end

        checks = if argv.empty?
          CHECKS
        else
          argv.map { |a| a.tr("-", "_").to_sym }
        end

        UI.header "Check"
        start = Process.clock_gettime(Process::CLOCK_MONOTONIC)

        passed = 0
        failed = 0
        print_mutex = Mutex.new

        threads = checks.map do |check|
          Thread.new(check) do |c|
            t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
            begin
              ok, message = send(:"check_#{c}")
              elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0
            rescue => e
              ok = false
              message = "ERROR: #{e.message}"
              elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0
            end

            name = c.to_s.tr("_", "-")
            time = UI.dim(UI.format_time(elapsed).rjust(7))
            print_mutex.synchronize do
              if ok
                $stderr.puts "  #{UI.green("✓")} #{name.ljust(24)} #{time}  #{message}"
                passed += 1
              else
                $stderr.puts "  #{UI.red("✗")} #{name.ljust(24)} #{time}  #{message}"
                failed += 1
              end
            end
          end
        end

        threads.each(&:join)
        total_time = UI.format_time(Process.clock_gettime(Process::CLOCK_MONOTONIC) - start)
        UI.summary(
          "#{passed} passed",
          failed > 0 ? UI.red("#{failed} failed") : "0 failed",
          "time #{UI.dim(total_time)}"
        )
        exit 1 if failed > 0
      end

      private

      # ── nix-eval ─────────────────────────────────────────────────

      def check_nix_eval
        nix_dir = @project.nix_dir
        return [true, "no nix/ dir"] unless Dir.exist?(nix_dir)

        files = Dir.glob(File.join(nix_dir, "**", "*.nix")) +
                Dir.glob(File.join(@project.overlays_dir, "**", "*.nix"))
        files.uniq!

        errors = 0
        mutex = Mutex.new

        files.each_slice([files.size / Etc.nprocessors, 1].max).map do |batch|
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

      # ── packageset-complete ──────────────────────────────────────
      # Every buildable package in each packageset has a generated file.

      def check_packageset_complete
        packagesets = Dir.glob(File.join(@project.packagesets_dir, "*.jsonl"))
        return [true, "no packagesets"] if packagesets.empty?

        missing = Set.new
        total = 0

        packagesets.each do |f|
          project = File.basename(f, ".jsonl")
          _meta, entries = Packageset.read(f)
          entries.each do |e|
            next if e.source == "stdlib" || e.source == "path"
            total += 1
            base_dir = e.installer == "node" ? @project.node_dir : @project.ruby_dir
            filename = e.name
            nix_file = File.join(base_dir, "#{filename}.nix")
            unless File.exist?(nix_file)
              missing << filename
            end
          end
        end

        if missing.any?
          sample = missing.to_a.sort.first(10).join(", ")
          [false, "#{missing.uniq.size} packages missing from generated files — run `onix generate`\n  #{sample}"]
        else
          [true, "#{total} packages all have generated files"]
        end
      end

      # ── packageset-metadata ──────────────────────────────────────
      # Soft warning check for lockfile metadata presence.

      def check_packageset_metadata
        packagesets = Dir.glob(File.join(@project.packagesets_dir, "*.jsonl"))
        return [true, "no packagesets"] if packagesets.empty?

        missing = []

        packagesets.each do |f|
          project = File.basename(f, ".jsonl")
          meta, _entries = Packageset.read(f)
          next if meta.nil?
          next if meta.lockfile_path && !meta.lockfile_path.empty?

          missing << project
        end

        if missing.empty?
          [true, "metadata complete"]
        else
          sample = missing.sort.first(10).join(", ")
          [true, "warning: #{missing.size} packagesets missing lockfile_path — run `onix backfill`\n  #{sample}"]
        end
      end

      # ── secrets ──────────────────────────────────────────────────

      def check_secrets
        gitleaks = `which gitleaks 2>/dev/null`.strip
        if gitleaks.empty?
          return [true, "skipped — install gitleaks"]
        end

        scan_dirs = %w[overlays nix packagesets log logs].map do |d|
          dir = File.join(@project.root, d)
          Dir.exist?(dir) ? dir : nil
        end.compact
        return [true, "no directories to scan"] if scan_dirs.empty?

        report = File.join(Dir.tmpdir, "gitleaks-#{$$}.json")
        all_findings = []

        scan_dirs.each do |dir|
          Open3.capture2e(
            gitleaks, "detect", "--source", dir,
            "--no-git", "--report-format", "json", "--report-path", report,
            "--exit-code", "0"
          )
          if File.exist?(report)
            results = JSON.parse(File.read(report))
            all_findings.concat(results)
            File.delete(report) rescue nil
          end
        end

        if all_findings.empty?
          [true, "clean"]
        else
          [false, "#{all_findings.size} potential secrets"]
        end
      end
    end
  end
end
