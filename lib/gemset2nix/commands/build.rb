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

      # Build a specific gem by path: nokogiri/1.19.0 or just nokogiri (latest)
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
          $stderr.puts "Building #{name} #{parts[1]}..."
          exec_nix_build(version_dir)
        else
          # Build latest version
          versions = Dir.children(gem_dir)
            .select { |d| d != "default.nix" && File.directory?(File.join(gem_dir, d)) && !d.start_with?("git-") }
            .sort_by { |v| Gem::Version.new(v) rescue Gem::Version.new("0") }
          abort "No versions found for #{name}" if versions.empty?
          latest = versions.last
          $stderr.puts "Building #{name} #{latest}..."
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

      # Build a specific gem from an app's gemset
      def build_app_gem(app, gem_name)
        app_nix = File.join(@project.app_dir, "#{app}.nix")
        abort "Unknown app: #{app}" unless File.exist?(app_nix)

        $stderr.puts "Building #{gem_name} from #{app}..."
        exec "nix-build", "--no-out-link", "-E", <<~NIX
          let pkgs = import <nixpkgs> {};
              ruby = pkgs.#{@ruby};
              resolve = import #{@project.modules_dir}/resolve.nix;
              gems = resolve { inherit pkgs ruby; gemset = import #{app_nix}; };
          in gems."#{gem_name}"
        NIX
      end

      # Build all gems for an app
      def build_app(app)
        app_nix = File.join(@project.app_dir, "#{app}.nix")
        abort "Unknown app: #{app}" unless File.exist?(app_nix)

        $stderr.puts "Building all gems for #{app}..."
        run_with_failure_log do |log|
          paths, _ = nix_build_keep_going(<<~NIX, log)
            let pkgs = import <nixpkgs> {};
                ruby = pkgs.#{@ruby};
                resolve = import #{@project.modules_dir}/resolve.nix;
                gems = resolve { inherit pkgs ruby; gemset = import #{app_nix}; };
            in builtins.attrValues gems
          NIX
          n = paths.count { |p| p.start_with?("/nix/store/") }
          $stderr.puts "#{n} gems built for #{app}."
        end
      end

      # Build every gem version in the pool
      def build_all
        total = Dir.glob(File.join(@project.output_dir, "*", "*")).count { |d|
          File.directory?(d) && !File.basename(d).start_with?("git-") && File.basename(d) != "default.nix"
        }
        $stderr.puts "Building #{total} gem derivations..."

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

        run_with_failure_log do |log|
          paths, _ = nix_build_keep_going(nixexpr.path, log, is_file: true)
          built = paths.count { |p| p.start_with?("/nix/store/") }
          failed = [total - built, 0].max
          $stderr.puts "#{built}/#{total} built, #{failed} failed."
        end
      ensure
        nixexpr&.close
        nixexpr&.unlink
      end

      def nix_build_keep_going(expr, log_path, is_file: false)
        cmd = ["nix-build", "--no-out-link", "--keep-going"]
        if is_file
          cmd << expr
        else
          cmd += ["-E", expr]
        end

        stdout_lines = []
        Open3.popen3(*cmd) do |_in, stdout, stderr, wait|
          stderr_thread = Thread.new do
            stderr.each_line do |line|
              File.open(log_path, "a") { |f| f.puts line }
              $stderr.write line
            end
          end

          stdout.each_line do |line|
            stdout_lines << line.strip
          end

          stderr_thread.join
          wait.value
        end

        [stdout_lines, log_path]
      end

      def run_with_failure_log
        log = File.join(Dir.tmpdir, "gem-build-#{$$}.log")
        yield log
        collect_failure_logs(log)
      ensure
        File.delete(log) if File.exist?(log) && !@keep_log
      end

      def collect_failure_logs(log)
        return unless File.exist?(log)
        content = File.read(log)
        drvs = content.scan(%r{/nix/store/\S+\.drv}).uniq
        return if drvs.empty?

        @keep_log = true
        $stderr.puts "\nFailed gems:"
        drvs.each do |drv|
          basename = drv.sub(%r{.*/[a-z0-9]*-}, "").sub(/\.drv$/, "")
          gem_name = basename.sub(/-[0-9][0-9.]*$/, "")
          gem_version = basename[/[0-9][0-9.]*$/] || "unknown"
          overlay = File.join(@project.overlays_dir, "#{gem_name}.nix")

          if File.exist?(overlay)
            $stderr.puts "  ✗ #{gem_name} #{gem_version}  →  edit overlays/#{gem_name}.nix"
          else
            $stderr.puts "  ✗ #{gem_name} #{gem_version}  →  create overlays/#{gem_name}.nix"
          end
        end
        $stderr.puts "\nBuild log: #{log}"
      end
    end
  end
end
