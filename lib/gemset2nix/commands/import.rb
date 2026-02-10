# frozen_string_literal: true

require "bundler"
require "digest"
require "fileutils"
require "pathname"
require "uri"
require "net/http"
require "json"

module Gemset2Nix
  module Commands
    class Import
      def run(argv)
        @project = Project.new
        name_override = nil
        from_index = false
        index_count = 1000
        index_versions = 3

        while argv.first&.start_with?("-")
          case argv.shift
          when "--name", "-n"      then name_override = argv.shift
          when "--from-index"      then from_index = true
          when "--count", "-c"     then index_count = argv.shift.to_i
          when "--versions"        then index_versions = argv.shift.to_i
          when "--help", "-h"
            usage
            exit 0
          else
            $stderr.puts "Unknown option. Use --help."
            exit 1
          end
        end

        if from_index
          import_from_index(name_override || "index", index_count, index_versions)
        else
          if argv.empty?
            usage
            exit 1
          end
          import_from_gemfile(argv.first, name_override)
        end
      end

      private

      def usage
        $stderr.puts <<~USAGE
          Usage: gemset2nix import [options] <path>

          Import gems into gemset2nix from a Gemfile.lock or the rubygems.org index.

          From Gemfile.lock:
            gemset2nix import path/to/Gemfile.lock
            gemset2nix import path/to/myapp/              # finds Gemfile.lock in dir
            gemset2nix import --name myapp Gemfile.lock    # override project name

          From rubygems.org index (top gems by download count):
            gemset2nix import --from-index                 # top 1000, 3 versions each
            gemset2nix import --from-index --count 500     # top 500
            gemset2nix import --from-index --versions 5    # 5 versions per gem
            gemset2nix import --from-index --name top      # custom gemset name

          Options:
            --name, -n NAME       Override the project/gemset name
            --from-index          Import from rubygems.org index instead of Gemfile.lock
            --count, -c N         Number of top gems to fetch (default: 1000)
            --versions N          Versions per gem to include (default: 3)
        USAGE
      end

      # ── Import from Gemfile.lock ──────────────────────────────────────

      def import_from_gemfile(arg, name_override)
        lockfile, project_name = resolve_lockfile(arg, name_override)

        UI.header "Import #{UI.bold(project_name)}"
        UI.info lockfile

        gemfile = lockfile.sub(/Gemfile\.lock$/, "Gemfile")
        ENV["BUNDLE_GEMFILE"] = File.expand_path(gemfile) if File.exist?(gemfile)

        lf = Bundler::LockfileParser.new(File.read(lockfile))
        rubygem_specs, git_repos = classify_specs(lf)

        write_gemset(project_name, lockfile)
        write_app_nix(project_name, rubygem_specs, git_repos)
        rebuild_apps_registry
      end

      def resolve_lockfile(arg, name_override)
        path = File.expand_path(arg)

        if File.directory?(path)
          lockfile = File.join(path, "Gemfile.lock")
          abort "No Gemfile.lock in #{path}" unless File.exist?(lockfile)
        elsif File.basename(path) == "Gemfile"
          lockfile = "#{path}.lock"
          abort "No Gemfile.lock found next to #{path}" unless File.exist?(lockfile)
        elsif File.exist?(path)
          lockfile = path
        else
          abort "Not found: #{arg}"
        end

        project = name_override || File.basename(File.dirname(lockfile))
        [lockfile, project]
      end

      # ── Import from rubygems.org index ────────────────────────────────

      def import_from_index(name, count, max_versions)
        UI.header "Import from rubygems.org"

        gem_names = fetch_top_gem_names(count)
        UI.info "#{gem_names.size} gem names"

        lines = []
        skipped = 0
        progress = UI::Progress.new(gem_names.size, label: "Versions")

        gem_names.each do |gem_name|
          versions = fetch_gem_versions(gem_name, max_versions)
          if versions
            versions.each { |v| lines << "#{gem_name} #{v}" }
            progress.advance
          else
            skipped += 1
            progress.advance(success: false)
          end
          sleep 0.1 # rate limit
        end
        progress.finish

        # Write as a synthetic Gemfile.lock (GEM section only)
        FileUtils.mkdir_p(@project.gemsets_dir)
        out = "GEM\n  remote: https://rubygems.org/\n  specs:\n"
        lines.sort.each { |l| n, ver = l.split(" ", 2); out << "    #{n} (#{ver})\n" }
        out << "\n"
        path = File.join(@project.gemsets_dir, "#{name}.gemset")
        File.write(path, out)
        UI.wrote "gemsets/#{name}.gemset #{UI.dim("(#{lines.size} versions)")}"
      end

      def fetch_top_gem_names(count)
        per_page = 30
        pages = (count.to_f / per_page).ceil
        names = []
        progress = UI::Progress.new(pages, label: "Index")

        pages.times do |i|
          uri = URI("https://rubygems.org/api/v1/search.json?query=*&page=#{i + 1}")
          resp = http_get_with_retry(uri)
          break(progress.advance(success: false)) unless resp

          data = JSON.parse(resp)
          break(progress.advance(success: false)) if data.empty?

          data.each { |g| names << g["name"] }
          progress.advance
          sleep 0.5
          break if names.size >= count
        end
        progress.finish

        names.first(count)
      end

      def fetch_gem_versions(name, max_versions)
        uri = URI("https://rubygems.org/info/#{name}")
        body = http_get_with_retry(uri)
        return nil unless body

        versions = []
        body.each_line do |line|
          line = line.strip
          next if line == "---" || line.empty?

          ver = line.split(" ", 2).first
          # Skip platform-specific and prerelease
          next if ver =~ /-(java|x86|x64|mingw|mswin|arm|aarch|darwin|linux|musl|freebsd)/i
          next if ver =~ /[a-zA-Z]/
          versions << ver
        end

        versions.uniq
          .sort_by { |v| Gem::Version.new(v) rescue Gem::Version.new("0") }
          .last(max_versions)
      end

      def http_get_with_retry(uri, retries: 3)
        retries.times do |attempt|
          resp = Net::HTTP.get_response(uri)
          if resp.code == "429"
            wait = (resp["retry-after"] || "2").to_i + 1
            sleep wait
            next
          end
          return resp.body if resp.code == "200"
          return nil
        end
        nil
      end

      # ── Gemfile.lock classification ───────────────────────────────────

      def classify_specs(lf)
        rubygem_specs = []
        git_specs = []

        lf.specs.each do |spec|
          src = spec.source
          case src
          when Bundler::Source::Git
            base = File.basename(src.uri, ".git")
            rev = src.options["revision"]
            git_specs << { spec: spec, uri: src.uri, rev: rev,
                           base: base, shortrev: rev[0, 12] }
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

        git_repos = {}
        git_specs.each do |gs|
          key = "#{gs[:base]}-#{gs[:shortrev]}"
          unless git_repos[key]
            git_repos[key] = { uri: gs[:uri], rev: gs[:rev], base: gs[:base],
                               shortrev: gs[:shortrev], gems: [] }
          end
          git_repos[key][:gems] << gs[:spec] unless git_repos[key][:gems].any? { |e| e.name == gs[:spec].name }
        end

        UI.info "#{rubygem_specs.size} rubygems, #{git_specs.size} git #{UI.dim("(#{git_repos.size} repos)")}"
        [rubygem_specs, git_repos]
      end

      # ── Output writers ────────────────────────────────────────────────

      def write_gemset(project_name, lockfile)
        # The gemset IS the Gemfile.lock — just copy it.
        FileUtils.mkdir_p(@project.gemsets_dir)
        dest = File.join(@project.gemsets_dir, "#{project_name}.gemset")
        FileUtils.cp(lockfile, dest)
        UI.wrote "gemsets/#{project_name}.gemset"
      end

      def write_app_nix(project_name, rubygem_specs, git_repos)
        nix = +""
        nix << NixWriter::BANNER_IMPORT
        nix << "# #{project_name.upcase} — #{rubygem_specs.size + git_repos.values.sum { |r| r[:gems].size }} gems\n"
        nix << "#\n[\n"

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
        UI.wrote "nix/app/#{project_name}.nix"
      end

      def rebuild_apps_registry
        apps = +""
        apps << NixWriter::BANNER_IMPORT
        apps << "# App presets for gem.app.<name>.enable = true\n#\n{\n"
        Dir.glob(File.join(@project.app_dir, "*.nix")).sort.each do |f|
          name = File.basename(f, ".nix")
          apps << "  #{name.inspect} = import ../app/#{name}.nix;\n"
        end
        apps << "}\n"

        FileUtils.mkdir_p(@project.modules_dir)
        File.write(File.join(@project.modules_dir, "apps.nix"), apps)
        UI.wrote "nix/modules/apps.nix"
      end

    end
  end
end
