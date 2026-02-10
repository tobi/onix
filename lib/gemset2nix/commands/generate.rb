# frozen_string_literal: true

require "scint/lockfile/parser"
require "scint/materializer"
require "json"
require "fileutils"
require "pathname"
require "set"

module Gemset2Nix
  module Commands
    class Generate
      include NixWriter

      # Map pkg-config module names to nixpkgs attribute paths.
      PKG_CONFIG_TO_NIX = {
        "yaml-0.1"  => "libyaml",
        "yaml-0"    => "libyaml",
        "libffi"    => "libffi",
        "libiconv"  => "libiconv",
        "openssl"   => "openssl",
        "zlib"      => "zlib",
        "libxml-2.0" => "libxml2",
        "libxslt"   => "libxslt",
        "libexslt"  => "libxslt",
        "sqlite3"   => "sqlite",
        "libcurl"   => "curl",
        "glib-2.0"  => "glib",
        "gobject-2.0" => "glib",
        "gio-2.0"   => "glib",
        "cairo"     => "cairo",
        "pangocairo" => "pango",
        "gdk-pixbuf-2.0" => "gdk-pixbuf",
        "vips"      => "vips",
        "MagickWand" => "imagemagick",
      }.freeze

      LIBRARY_TO_NIX = {
        "ssl"       => "openssl",
        "crypto"    => "openssl",
        "z"         => "zlib",
        "zlib"      => "zlib",
        "xml2"      => "libxml2",
        "libxml2"   => "libxml2",
        "xslt"      => "libxslt",
        "exslt"     => "libxslt",
        "yaml"      => "libyaml",
        "libyaml"   => "libyaml",
        "ffi"       => "libffi",
        "libffi"    => "libffi",
        "libffi-8"  => "libffi",
        "iconv"     => "libiconv",
        "libiconv"  => "libiconv",
        "curl"      => "curl",
        "libcurl"   => "curl",
        "sqlite3"   => "sqlite",
        "gmp"       => "gmp",
        "readline"  => "readline",
        "ncurses"   => "ncurses",
        "ncursesw"  => "ncurses",
        "vips"      => "vips",
      }.freeze

      C_INCLUDE_TO_NIX = {
        "openssl" => "openssl",
        "libxml"  => "libxml2",
        "libxslt" => "libxslt",
        "yaml"    => "libyaml",
        "zlib"    => "zlib",
        "sqlite3" => "sqlite",
        "curl"    => "curl",
        "ffi"     => "libffi",
        "mysql"   => "libmysqlclient",
        "glib"    => "glib",
        "gobject" => "glib",
        "gio"     => "glib",
        "cairo"   => "cairo",
        "pango"   => "pango",
        "gdk-pixbuf" => "gdk-pixbuf",
        "vips"    => "vips",
      }.freeze

      DIR_CONFIG_TO_NIX = {
        "openssl"    => "openssl",
        "zlib"       => "zlib",
        "libyaml"    => "libyaml",
        "libxml2"    => "libxml2",
        "libxslt"    => "libxslt",
        "sqlite3"    => "sqlite",
        "libffi"     => "libffi",
        "readline"   => "readline",
        "ncurses"    => "ncurses",
        "curl"       => "curl",
        "iconv"      => "libiconv",
      }.freeze

      BUILD_TOOL_TO_NIX = {
        "perl"    => "perl",
        "python"  => "python3",
        "python3" => "python3",
        "cmake"   => "cmake",
      }.freeze

      def run(argv)
        @project = Project.new
        @meta = @project.load_metadata
        @overlays = Set.new(@project.overlays)
        @tpl = NixTemplate.new

        UI.header "Generate"
        UI.info "#{@meta.size} gems in cache #{UI.dim("(#{@overlays.size} overlays)")}"

        generate_derivations
        generate_selectors
        generate_git_derivations
        generate_catalogue

        $stderr.puts
        UI.info "Run #{UI.amber("gemset2nix check")} to verify"
      end

      private

      # ── Per-gem derivation ────────────────────────────────────────

      def generate_derivations
        generated = 0

        @meta.each_value do |meta|
          name    = meta[:name]
          version = meta[:version]
          key     = "#{name}-#{version}"
          source  = File.join(@project.source_dir, key)
          next unless Dir.exist?(source)

          has_ext = meta[:has_extensions] || !Dir.glob(File.join(source, "ext", "**", "extconf.rb")).empty?
          require_paths = meta[:require_paths] || ["lib"]
          executables   = meta[:executables] || []
          bindir        = meta[:bindir] || "exe"

          verified = require_paths.select { |p| Dir.exist?(File.join(source, p)) }
          require_paths = verified unless verified.empty?

          gem_dir = File.join(@project.output_dir, name, version)
          FileUtils.mkdir_p(gem_dir)
          link = File.join(gem_dir, "source")
          FileUtils.rm_f(link)
          FileUtils.ln_s(File.expand_path(source), link)

          has_overlay = @overlays.include?(name)
          scan = has_ext && !has_overlay ? ExtconfScanner.scan(source) : nil
          has_auto = scan&.needs_auto_deps?
          auto_nix_deps = has_auto && scan ? resolve_nix_deps(scan) : []
          needs_pkgs = has_overlay || (scan && (scan.is_rust || !auto_nix_deps.empty?))
          has_prebuilt = !has_ext && !Dir.glob(File.join(source, "**", "*.{so,bundle}")).empty?

          # Resolve build gem imports for the let-block
          gem_path_entries = []
          if !has_overlay && scan
            gem_path_entries = resolve_gem_path_entries(scan)
          end

          nix = @tpl.derivation(
            name: name, version: version,
            has_ext: has_ext, has_overlay: has_overlay,
            scan: scan, has_auto: has_auto, needs_pkgs: needs_pkgs,
            auto_nix_deps: auto_nix_deps,
            require_paths: require_paths, executables: executables, bindir: bindir,
            has_prebuilt: has_prebuilt,
            auto_build_gems: missing_build_gems(scan),
            gem_path_entries: gem_path_entries,
          )

          File.write(File.join(gem_dir, "default.nix"), nix)
          generated += 1
        end

        UI.done "#{generated} derivations"
      end

      # Resolve scanner's build gem deps into let-block import entries.
      # Returns [{ varname:, import_path: }]
      def resolve_gem_path_entries(scan)
        entries = []

        if scan.is_rust
          rb_sys_dir = File.join(@project.output_dir, "rb_sys")
          if Dir.exist?(rb_sys_dir)
            versions = version_dirs(rb_sys_dir)
            unless versions.empty?
              entries << { varname: "rb_sys", import_path: "../../rb_sys/#{versions.last}" }
            end
          end
        end

        scan.build_gem_deps.reject { |g| g == "rb_sys" }.each do |gdep|
          gdep_dir = File.join(@project.output_dir, gdep)
          if Dir.exist?(gdep_dir)
            versions = version_dirs(gdep_dir)
            unless versions.empty?
              entries << { varname: gdep.tr("-", "_"), import_path: "../../#{gdep}/#{versions.last}" }
            end
          end
        end

        entries
      end

      # Resolve all scanner signals into a deduplicated list of nixpkgs attrs.
      def resolve_nix_deps(scan)
        nix_deps = Set.new

        scan.pkg_configs.each { |pc| nix_deps << PKG_CONFIG_TO_NIX.fetch(pc, pc) }
        scan.libraries.each { |lib| nix_pkg = LIBRARY_TO_NIX[lib]; nix_deps << nix_pkg if nix_pkg }
        scan.dir_configs.each { |dc| nix_pkg = DIR_CONFIG_TO_NIX[dc]; nix_deps << nix_pkg if nix_pkg }
        scan.c_includes.each { |inc| nix_pkg = C_INCLUDE_TO_NIX[inc]; nix_deps << nix_pkg if nix_pkg }
        scan.build_tools.each { |tool| nix_pkg = BUILD_TOOL_TO_NIX[tool]; nix_deps << nix_pkg if nix_pkg }
        nix_deps << "pkg-config" unless scan.pkg_configs.empty?

        nix_deps.to_a.sort
      end

      def missing_build_gems(scan)
        return [] unless scan
        scan.build_gem_deps.select { |g| !Dir.exist?(File.join(@project.output_dir, g)) }
      end

      def version_dirs(dir)
        Dir.children(dir)
          .select { |d| d != "default.nix" && File.directory?(File.join(dir, d)) && !d.start_with?("git-") }
          .sort_by { |v| Gem::Version.new(v) rescue Gem::Version.new("0") }
      end

      # ── Git repo derivations ──────────────────────────────────────

      def generate_git_derivations
        repos = {}
        mat = @project.materializer
        Dir.glob(File.join(@project.gemsets_dir, "*.gemset")).each do |f|
          lockdata = @project.parse_lockfile(f)
          classified = mat.classify(lockdata)
          classified[:git].each { |key, repo| repos[key] ||= repo }
        end

        return if repos.empty?

        generated = 0
        repos.each do |repo_key, repo|
          source_dir = repo[:gems].lazy.map { |g|
            File.join(@project.source_dir, "#{g[:name]}-#{g[:version]}")
          }.find { |d| Dir.exist?(d) }

          unless source_dir
            UI.warn "no source for git repo #{repo_key} (run gemset2nix fetch)"
            next
          end

          git_dir = File.join(@project.output_dir, repo[:base], "git-#{repo[:shortrev]}")
          FileUtils.mkdir_p(git_dir)
          source_link = File.join(git_dir, "source")
          FileUtils.rm_f(source_link)
          FileUtils.ln_s(File.expand_path(source_dir), source_link)

          missing_gemspecs = repo[:gems].select do |g|
            !File.exist?(File.join(source_dir, "#{g[:name]}.gemspec")) &&
              !File.exist?(File.join(source_dir, g[:name], "#{g[:name]}.gemspec"))
          end

          nix = @tpl.git_derivation(repo_key: repo_key, repo: repo, missing_gemspecs: missing_gemspecs)
          File.write(File.join(git_dir, "default.nix"), nix)
          generated += 1

          patch_git_selector(repo)
        end

        UI.done "#{generated} git derivations" if generated > 0
      end

      def patch_git_selector(repo)
        selector_path = File.join(@project.output_dir, repo[:base], "default.nix")

        if File.exist?(selector_path)
          selector = File.read(selector_path)
          rev_line = "    #{repo[:shortrev].inspect} = import ./git-#{repo[:shortrev]} { inherit lib stdenv ruby; };\n"
          unless selector.include?(repo[:shortrev].inspect)
            selector.sub!("  gitRevs = {\n", "  gitRevs = {\n#{rev_line}")
            File.write(selector_path, selector)
          end
        else
          nix = @tpl.git_only_selector(name: repo[:base], shortrev: repo[:shortrev])
          FileUtils.mkdir_p(File.dirname(selector_path))
          File.write(selector_path, nix)
          @gems_by_name[repo[:base]] ||= { versions: [], needs_pkgs: false }
        end
      end

      # ── Selectors ─────────────────────────────────────────────────

      def generate_selectors
        @gems_by_name = {}
        @gems_needing_pkgs = Set.new(@overlays)

        @meta.each_value do |meta|
          name = meta[:name]
          version = meta[:version]
          source = File.join(@project.source_dir, "#{name}-#{version}")
          next unless Dir.exist?(source)

          info = (@gems_by_name[name] ||= { versions: [], needs_pkgs: @overlays.include?(name) })
          info[:versions] << version

          unless info[:needs_pkgs]
            has_ext = meta[:has_extensions] || !Dir.glob(File.join(source, "ext", "**", "extconf.rb")).empty?
            if has_ext
              scan = ExtconfScanner.scan(source)
              if scan.needs_auto_deps? && !resolve_nix_deps(scan).empty?
                info[:needs_pkgs] = true
                @gems_needing_pkgs << name
              end
            end
          end
        end

        @gems_by_name.each do |name, info|
          versions = info[:versions].sort_by { |v| Gem::Version.new(v) }
          nix = @tpl.selector(name: name, versions: versions, needs_pkgs: info[:needs_pkgs])
          File.write(File.join(@project.output_dir, name, "default.nix"), nix)
        end

        UI.done "#{@gems_by_name.size} selectors"
      end

      # ── Catalogue ─────────────────────────────────────────────────

      def generate_catalogue
        nix = @tpl.catalogue(gem_names: @gems_by_name.keys)
        FileUtils.mkdir_p(@project.modules_dir)
        File.write(File.join(@project.modules_dir, "gem.nix"), nix)
        UI.wrote "nix/modules/gem.nix"
      end
    end
  end
end
