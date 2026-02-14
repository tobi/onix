# frozen_string_literal: true

require "etc"
require "json"
require "open3"
require "tmpdir"
require_relative "../packageset"

module Onix
  module Commands
    class Check
      CHECKS = %i[
        nix_eval
        packageset_complete
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
        UI.summary("#{passed} passed", failed > 0 ? UI.red("#{failed} failed") : "0 failed")
        exit 1 if failed > 0
      end

      private

      def nix_file_for(entry)
        if entry.installer == "node"
          File.join(@project.nix_dir, "node", "#{entry.safe_nix_filename}.nix")
        else
          File.join(@project.ruby_dir, "#{entry.name}.nix")
        end
      end

      # ── nix-eval ─────────────────────────────────────────────────

      def check_nix_eval
        nix_dir = @project.nix_dir
        return [true, "no nix/ dir"] unless Dir.exist?(nix_dir)

        files = Dir.glob(File.join(nix_dir, "**", "*.nix"))
        files += Dir.glob(File.join(@project.overlays_dir, "*.nix")) if Dir.exist?(@project.overlays_dir)
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
      # Every buildable package in each packageset has a corresponding nix file

      def check_packageset_complete
        packagesets = Dir.glob(File.join(@project.packagesets_dir, "*.jsonl"))
        return [true, "no packagesets"] if packagesets.empty?

        missing = []
        total = 0

        packagesets.each do |f|
          _meta, entries = Packageset.read(f)
          entries.each do |e|
            next if e.source == "stdlib" || e.source == "path" || e.source == "builtin"
            total += 1

            nix_file = nix_file_for(e)
            missing << e.name unless File.exist?(nix_file)
          end
        end

        if missing.any?
          sample = missing.uniq.first(10).join(", ")
          [false, "#{missing.uniq.size} packages missing from nix/ — run `onix generate`\n  #{sample}"]
        else
          [true, "#{total} packages all have nix files"]
        end
      end

      # ── secrets ──────────────────────────────────────────────────

      def check_secrets
        gitleaks = `which gitleaks 2>/dev/null`.strip
        if gitleaks.empty?
          return [true, "skipped — install gitleaks"]
        end

        scan_dirs = %w[overlays nix packagesets].filter_map do |d|
          dir = File.join(@project.root, d)
          Dir.exist?(dir) ? dir : nil
        end
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
