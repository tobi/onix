# frozen_string_literal: true

require "open3"
require "tempfile"

module Gemset2Nix
  module Commands
    class Build
      def run(argv)
        @project = Project.new
        @ruby = ENV.fetch("RUBY", "ruby_3_4")

        gem_path = nil

        while argv.first&.start_with?("-")
          case argv.shift
          when "--gem", "-g" then gem_path = argv.shift
          when "--ruby", "-r" then @ruby = argv.shift
          when "--help", "-h"
            usage
            exit 0
          end
        end

        if gem_path
          build_gem_path(gem_path)
        elsif argv.size == 2
          build_app_gem(argv[0], argv[1])
        elsif argv.size == 1
          build_app(argv[0])
        else
          build_all
        end
      end

      private

      def usage
        $stderr.puts <<~USAGE
          Usage: gemset2nix build [options] [app] [gem]

          Build gem derivations via Nix.

          Examples:
            gemset2nix build                        # build every gem in the pool
            gemset2nix build fizzy                   # build all gems for an app
            gemset2nix build fizzy rack              # build a specific gem from an app
            gemset2nix build --gem nokogiri/1.19.0   # build a specific gem+version
            gemset2nix build --gem nokogiri          # build latest version

          Options:
            --gem, -g NAME[/VERSION]   Build a specific gem derivation
            --ruby, -r ATTR            Nix ruby attribute (default: ruby_3_4)
        USAGE
      end

      # ── Single gem build ─────────────────────────────────────────

      def build_gem_path(path)
        parts = path.split("/", 2)
        name = parts[0]
        gem_dir = File.join(@project.output_dir, name)

        unless Dir.exist?(gem_dir)
          abort "Unknown gem: #{name}. Not found in #{@project.output_dir}/#{name}/"
        end

        if parts[1]
          version_dir = File.join(gem_dir, parts[1])
          abort "Unknown version: #{path}" unless Dir.exist?(version_dir)
          UI.header "Build"
          UI.info "#{name} #{parts[1]}"
          exec_nix_build(version_dir)
        else
          versions = Dir.children(gem_dir)
            .select { |d| d != "default.nix" && File.directory?(File.join(gem_dir, d)) && !d.start_with?("git-") }
            .sort_by { |v| Gem::Version.new(v) rescue Gem::Version.new("0") }
          abort "No versions found for #{name}" if versions.empty?
          latest = versions.last
          UI.header "Build"
          UI.info "#{name} #{latest}"
          exec_nix_build(File.join(gem_dir, latest))
        end
      end

      def exec_nix_build(derivation_dir)
        exec "nix-build", "--no-out-link", derivation_dir,
          "--arg", "ruby", "(import <nixpkgs> {}).#{@ruby}",
          "--arg", "lib", "(import <nixpkgs> {}).lib",
          "--arg", "stdenv", "(import <nixpkgs> {}).stdenv",
          "--arg", "pkgs", "import <nixpkgs> {}"
      end

      # ── App gem build ────────────────────────────────────────────

      def build_app_gem(app, gem_name)
        app_nix = File.join(@project.app_dir, "#{app}.nix")
        abort "Unknown app: #{app}" unless File.exist?(app_nix)

        UI.header "Build"
        UI.info "#{gem_name} #{UI.dim("from #{app}")}"
        exec "nix-build", "--no-out-link", "-E", <<~NIX
          let pkgs = import <nixpkgs> {};
              ruby = pkgs.#{@ruby};
              resolve = import #{@project.modules_dir}/resolve.nix;
              gems = resolve { inherit pkgs ruby; gemset = import #{app_nix}; };
          in gems."#{gem_name}"
        NIX
      end

      # ── App build ───────────────────────────────────────────────

      def build_app(app)
        app_nix = File.join(@project.app_dir, "#{app}.nix")
        abort "Unknown app: #{app}" unless File.exist?(app_nix)

        UI.header "Build"
        UI.info "#{app}"

        nix_build_with_progress(<<~NIX)
          let pkgs = import <nixpkgs> {};
              ruby = pkgs.#{@ruby};
              resolve = import #{@project.modules_dir}/resolve.nix;
              gems = resolve { inherit pkgs ruby; gemset = import #{app_nix}; };
          in builtins.attrValues gems
        NIX
      end

      # ── Build all ───────────────────────────────────────────────

      def build_all
        total = Dir.glob(File.join(@project.output_dir, "*", "*")).count { |d|
          File.directory?(d) && !File.basename(d).start_with?("git-") && File.basename(d) != "default.nix"
        }
        overlay_count = @project.overlays.size

        UI.header "Build"
        UI.info "#{total} gems #{UI.dim("(#{overlay_count} overlays)")}"

        nixexpr = Tempfile.new(["gem-build-all-", ".nix"])
        nixexpr.write(<<~NIX)
          let
            pkgs = import <nixpkgs> {};
            ruby = pkgs.#{@ruby};
            lib = pkgs.lib;
            root = #{@project.output_dir};
            dirs = builtins.attrNames (builtins.readDir root);
            versionsOf = name:
              let
                entries = builtins.readDir (root + "/\${name}");
                subdirs = lib.filterAttrs (k: v: v == "directory") entries;
              in
              map (v: pkgs.callPackage (root + "/\${name}/\${v}") { inherit ruby; })
                (builtins.attrNames subdirs);
          in
          lib.concatMap versionsOf dirs
        NIX
        nixexpr.flush

        nix_build_with_progress(nixexpr.path, is_file: true, total_hint: total)
      ensure
        nixexpr&.close
        nixexpr&.unlink
      end

      # ── Nix build with progress tracking ────────────────────────

      def nix_build_with_progress(expr, is_file: false, total_hint: nil)
        cmd = ["nix-build", "--no-out-link", "--keep-going"]
        if is_file
          cmd << expr
        else
          cmd += ["-E", expr]
        end

        built = 0
        failed_drvs = []
        building = {}    # drv_path => gem name
        log_lines = []
        t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)

        stdout_lines = []

        Open3.popen3(*cmd) do |_in, stdout, stderr, wait|
          stdout.set_encoding("UTF-8", invalid: :replace)
          stderr.set_encoding("UTF-8", invalid: :replace)

          stdout_thread = Thread.new do
            stdout.each_line { |l| stdout_lines << l.strip rescue nil }
          rescue IOError
            # stream closed — normal during shutdown
          end

          stderr.each_line do |line|
            log_lines << line
            line = line.strip rescue next

            case line
            when /^building '([^']+)'/ 
              drv = $1
              name = drv_to_gem_name(drv)
              building[drv] = name
              draw_building(building, built, failed_drvs.size, total_hint, t0)

            when /^copying outputs/
              # A build just finished successfully — we don't know which one here
              # but we can count stdout lines after the fact

            when /error: builder for '([^']+)' failed/,
                 /error: Cannot build '([^']+)'/
              drv = $1
              name = building.delete(drv) || drv_to_gem_name(drv)
              failed_drvs << { drv: drv, name: name } unless failed_drvs.any? { |f| f[:drv] == drv }
              draw_building(building, built, failed_drvs.size, total_hint, t0)

            when /^building '/, /^fetching '/, /^copying /
              # noise — skip

            else
              # Count successful builds from "these N paths will be built" and stdout
            end
          end

          stdout_thread.join
          wait.value
        end

        # Clear progress line
        $stderr.print "\r\e[K" if UI.tty?

        built = stdout_lines.count { |p| p.start_with?("/nix/store/") }
        total = total_hint || (built + failed_drvs.size)
        elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0

        # Summary
        if failed_drvs.empty?
          UI.done "#{built} built #{UI.dim(UI.format_time(elapsed))}"
        else
          UI.fail "#{built}/#{total} built, #{UI.red("#{failed_drvs.size} failed")} #{UI.dim(UI.format_time(elapsed))}"
          $stderr.puts
          failed_drvs.each do |f|
            overlay = File.join(@project.overlays_dir, "#{f[:name]}.nix")
            hint = File.exist?(overlay) ? "edit overlays/#{f[:name]}.nix" : "create overlays/#{f[:name]}.nix"
            UI.fail "#{f[:name]}  #{UI.dim("→")}  #{hint}"
            UI.step UI.dim("nix log #{f[:drv]}")
          end
        end
      end

      def draw_building(building, built, failed, total_hint, t0)
        return unless UI.tty?
        elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - t0
        active = building.values.last(3).join(", ")
        parts = []
        parts << "#{building.size} active"
        parts << UI.red("#{failed}✗") if failed > 0
        parts << UI.dim(UI.format_time(elapsed))
        $stderr.print "\r  #{UI.amber("▸")} #{active} #{UI.dim("(#{parts.join(", ")})") }\e[K"
      end

      def drv_to_gem_name(drv)
        basename = drv.sub(%r{.*/[a-z0-9]*-}, "").sub(/\.drv$/, "")
        basename.sub(/-[0-9][0-9.]*$/, "")
      end
    end
  end
end
