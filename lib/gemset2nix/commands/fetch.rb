# frozen_string_literal: true

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
        project = Project.new
        jobs = (ENV["JOBS"] || "20").to_i

        inputs = if argv.empty?
          Dir.glob(File.join(project.imports_dir, "*.gemset"))
        else
          argv.flat_map do |a|
            if File.directory?(a)
              Dir.glob(File.join(a, "*.gemset"))
            elsif File.file?(a)
              [a]
            else
              $stderr.puts "Not found: #{a}"
              []
            end
          end
        end

        if inputs.empty?
          $stderr.puts "No .gemset files found. Run 'gemset2nix import' first."
          exit 1
        end

        # Collect all lines, dedupe
        lines = inputs.flat_map { |f| File.readlines(f).map(&:strip) }
        lines.reject! { |l| l.empty? || l.start_with?("#") }
        lines.uniq!
        lines.sort!

        $stderr.puts "#{lines.size} unique gems to fetch (jobs=#{jobs})"

        done = 0
        failed = 0
        mutex = Mutex.new

        # Process in thread pool
        queue = Queue.new
        lines.each { |l| queue << l }
        jobs.times { queue << nil } # poison pills

        threads = jobs.times.map do
          Thread.new do
            while (line = queue.pop)
              parts = line.split
              name, version = parts[0], parts[1]
              git = parts[2]&.start_with?("git:") ? parts[2].sub("git:", "") : nil

              ok = if git
                fetch_git(project, name, version, git)
              else
                fetch_rubygem(project, name, version)
              end

              mutex.synchronize do
                if ok
                  done += 1
                  $stderr.print "\r  #{done}/#{lines.size} fetched" if done % 50 == 0 || done == lines.size
                else
                  failed += 1
                  $stderr.puts "FAIL: #{name}-#{version}"
                end
              end
            end
          end
        end

        threads.each(&:join)
        $stderr.puts
        $stderr.puts "#{done} fetched, #{failed} failed" if failed > 0
      end

      private

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
          $stderr.puts "ERROR: unpack #{name}-#{version}: #{err.strip}"
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
          $stderr.puts "WARN: metadata #{name}-#{version}: #{e.message}"
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

      def fetch_git(project, name, version, git_ref)
        target = File.join(project.source_dir, "#{name}-#{version}")
        return true if Dir.exist?(target)

        uri, rev = git_ref.split("@", 2)
        clone_dir = File.join(project.git_clones_dir, File.basename(uri, ".git"))

        FileUtils.mkdir_p(File.dirname(clone_dir))
        unless Dir.exist?(clone_dir)
          system("git", "clone", "--quiet", uri, clone_dir)
        end

        system("git", "-C", clone_dir, "fetch", "--quiet", "origin", err: "/dev/null")
        system("git", "-C", clone_dir, "checkout", "--quiet", "--force", rev)

        FileUtils.cp_r(clone_dir, target)
        FileUtils.rm_rf(File.join(target, ".git"))
        true
      end
    end
  end
end
