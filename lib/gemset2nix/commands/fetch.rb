# frozen_string_literal: true

require "bundler"
require "fileutils"
require "json"
require "open3"
require "yaml"
require "rubygems/package"
require "stringio"
require "zlib"

module Gemset2Nix
  module Commands
    class Fetch
      def run(argv)
        @project = project = Project.new
        jobs = (ENV["JOBS"] || "20").to_i

        while argv.first&.start_with?("-")
          case argv.shift
          when "-j", "--jobs" then jobs = argv.shift.to_i
          when "--help", "-h"
            $stderr.puts "Usage: gemset2nix fetch [options] [gemset files...]"
            $stderr.puts
            $stderr.puts "  -j, --jobs N    Parallel downloads (default: 20, env: JOBS)"
            exit 0
          end
        end

        inputs = if argv.empty?
          Dir.glob(File.join(project.gemsets_dir, "*.gemset"))
        else
          argv.flat_map do |a|
            if File.directory?(a)
              Dir.glob(File.join(a, "*.gemset"))
            elsif File.file?(a)
              [a]
            else
              UI.warn "Not found: #{a}"
              []
            end
          end
        end

        if inputs.empty?
          UI.fail "No .gemset files found. Run 'gemset2nix import' first."
          exit 1
        end

        # Parse via Bundler
        work = []
        inputs.each { |f| work.concat(parse_gemset(f)) }
        work.uniq! { |w| "#{w[:name]}-#{w[:version]}" }

        rubygems = work.reject { |w| w[:git_uri] }
        git_gems = work.select { |w| w[:git_uri] }

        UI.header "Fetch"
        UI.info "#{work.size} gems #{UI.dim("(#{rubygems.size} rubygems, #{git_gems.size} git)")}"

        # ── Git repos (sequential, fast) ────────────────────────────

        if git_gems.any?
          # Group by repo
          repos = {}
          git_gems.each do |g|
            key = "#{g[:git_uri]}@#{g[:git_rev]}"
            (repos[key] ||= []) << g
          end

          progress = UI::Progress.new(repos.size, label: "Git repos")
          repos.each do |_, gems|
            g = gems.first
            ok = fetch_git_repo(project, g[:git_uri], g[:git_rev], gems)
            progress.advance(success: ok)
          end
          progress.finish
        end

        # ── Rubygems (parallel) ─────────────────────────────────────

        if rubygems.any?
          progress = UI::Progress.new(rubygems.size, label: "Rubygems")

          queue = Queue.new
          rubygems.each { |w| queue << w }
          jobs.times { queue << nil }

          threads = jobs.times.map do
            Thread.new do
              while (item = queue.pop)
                cached = gem_cached?(project, item[:name], item[:version])
                ok = fetch_rubygem(project, item[:name], item[:version])
                progress.advance(success: ok, skip: cached && ok)
              end
            end
          end

          threads.each(&:join)
          progress.finish
        end
      end

      private

      # ── Gemset parsing ─────────────────────────────────────────────

      def parse_gemset(path)
        lf = @project.parse_lockfile(path)
        lf.specs.filter_map do |spec|
          src = spec.source
          case src
          when Bundler::Source::Git
            { name: spec.name, version: spec.version.to_s,
              git_uri: src.uri, git_rev: src.options["revision"] }
          when Bundler::Source::Path
            nil
          else
            { name: spec.name, version: spec.version.to_s,
              git_uri: nil, git_rev: nil }
          end
        end
      end

      # ── Rubygem fetching ───────────────────────────────────────────

      def gem_cached?(project, name, version)
        File.exist?(File.join(project.meta_dir, "#{name}-#{version}.json")) &&
          Dir.exist?(File.join(project.source_dir, "#{name}-#{version}"))
      end

      def fetch_rubygem(project, name, version)
        gem_file = File.join(project.gem_cache_dir, "#{name}-#{version}.gem")

        unless File.exist?(gem_file)
          FileUtils.mkdir_p(project.gem_cache_dir)
          _, _, status = Open3.capture3("gem", "fetch", name, "-v", version,
            "--platform", "ruby", chdir: project.gem_cache_dir)
          unless status.success?
            _, _, status = Open3.capture3("gem", "fetch", name, "-v", version,
              chdir: project.gem_cache_dir)
          end
          gem_file = Dir.glob(File.join(project.gem_cache_dir, "#{name}-#{version}*.gem")).sort.first
          return false unless gem_file && File.exist?(gem_file)
        end

        unpack_gem(project, gem_file, name, version)
        extract_metadata(project, gem_file, name, version)
        true
      end

      def unpack_gem(project, gem_file, name, version)
        target = File.join(project.source_dir, "#{name}-#{version}")
        return if Dir.exist?(target)

        FileUtils.mkdir_p(project.source_dir)
        _, err, status = Open3.capture3("gem", "unpack", gem_file, "--target", project.source_dir)
        unless status.success?
          $stderr.puts "\n  ERROR: unpack #{name}-#{version}: #{err.strip}"
          return
        end

        unpacked = Dir.glob(File.join(project.source_dir, "#{name}-#{version}*")).first
        FileUtils.mv(unpacked, target) if unpacked && unpacked != target

        # Strip prebuilt .so/.bundle/.dylib — we compile from source
        Dir.glob(File.join(target, "lib", "**", "*.{so,bundle,dylib}")).each { |f| File.delete(f) }
      end

      def extract_metadata(project, gem_file, name, version)
        meta_file = File.join(project.meta_dir, "#{name}-#{version}.json")
        return if File.exist?(meta_file)

        FileUtils.mkdir_p(project.meta_dir)
        meta = nil
        begin
          File.open(gem_file, "rb") do |io|
            Gem::Package::TarReader.new(io) do |tar|
              tar.each do |entry|
                if entry.full_name == "metadata.gz"
                  yaml = Zlib::GzipReader.new(StringIO.new(entry.read)).read
                  meta = YAML.safe_load(yaml,
                    permitted_classes: [Gem::Specification, Gem::Version, Gem::Requirement,
                                       Gem::Dependency, Symbol, Time],
                    aliases: true)
                  break
                end
              end
            end
          end
        rescue => e
          $stderr.puts "\n  WARN: metadata #{name}-#{version}: #{e.message}"
        end

        return unless meta

        source = File.join(project.source_dir, "#{name}-#{version}")
        has_extensions = if meta.respond_to?(:extensions) && !meta.extensions.empty?
          true
        elsif Dir.exist?(source)
          !Dir.glob(File.join(source, "ext", "**", "extconf.rb")).empty?
        else
          false
        end

        result = {
          "name" => name,
          "version" => version,
          "require_paths" => meta.require_paths || ["lib"],
          "executables" => meta.executables || [],
          "bindir" => meta.bindir || "exe",
          "has_extensions" => has_extensions,
          "dependencies" => (meta.dependencies || [])
            .select { |d| d.type == :runtime }
            .map { |d| { "name" => d.name, "requirement" => d.requirement.to_s } },
        }

        File.write(meta_file, JSON.pretty_generate(result))
      end

      # ── Git fetching ───────────────────────────────────────────────

      def fetch_git_repo(project, uri, rev, gems)
        # Check if all gems already extracted
        all_exist = gems.all? { |g| Dir.exist?(File.join(project.source_dir, "#{g[:name]}-#{g[:version]}")) }
        return true if all_exist

        clone_dir = File.join(project.git_clones_dir, File.basename(uri, ".git"))

        FileUtils.mkdir_p(File.dirname(clone_dir))
        unless Dir.exist?(clone_dir)
          _, _, status = Open3.capture3("git", "clone", "--quiet", uri, clone_dir)
          return false unless status.success?
        end

        Open3.capture3("git", "-C", clone_dir, "fetch", "--quiet", "origin")
        _, _, status = Open3.capture3("git", "-C", clone_dir, "checkout", "--quiet", "--force", rev)
        return false unless status.success?

        gems.each do |g|
          target = File.join(project.source_dir, "#{g[:name]}-#{g[:version]}")
          next if Dir.exist?(target)
          FileUtils.cp_r(clone_dir, target)
          FileUtils.rm_rf(File.join(target, ".git"))
        end

        true
      end
    end
  end
end
