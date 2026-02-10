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
      # Names not listed here are used as-is (pkgs.<name>).
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

      # Map have_library / dir_config names to nixpkgs attribute paths.
      # C library names from have_library() and dir_config() that we can
      # confidently map. Unknown names are ignored (need overlays).
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

      # Map C #include prefixes to nixpkgs attribute paths.
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

      # Map dir_config names to nixpkgs attribute paths.
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

      # Build tools → nixpkgs attribute paths
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

      # ── Per-gem derivation: nix/gem/<name>/<version>/default.nix ──────

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

          nix = build_derivation(
            name: name, version: version, key: key,
            has_ext: has_ext, has_overlay: has_overlay,
            scan: scan, has_auto: has_auto, needs_pkgs: needs_pkgs,
            auto_nix_deps: auto_nix_deps,
            require_paths: require_paths, executables: executables, bindir: bindir,
            source: source
          )

          File.write(File.join(gem_dir, "default.nix"), nix)
          generated += 1
        end

        UI.done "#{generated} derivations"
      end

      def build_derivation(name:, version:, key:, has_ext:, has_overlay:, scan:, has_auto:,
                           needs_pkgs:, auto_nix_deps: [], require_paths:, executables:, bindir:, source:)
        si = SH
        hd = HD
        nix = +""

        # Header
        nix << BANNER
        nix << "# #{name} #{version}\n"
        if has_auto && scan
          nix << "# auto-detected: pkg_config=[#{scan.pkg_configs.join(", ")}]"
          nix << " libs=[#{scan.libraries.join(", ")}]" unless scan.libraries.empty?
          nix << " rust" if scan.is_rust
          nix << " build-gems=[#{scan.build_gem_deps.join(", ")}]" unless scan.build_gem_deps.empty?
          nix << "\n"
        end
        nix << "#\n"

        # Function args
        args = ["lib", "stdenv", "ruby"]
        args << "pkgs" if needs_pkgs
        nix << "{\n"
        args.each { |a| nix << "  #{a},\n" }
        nix << "}:\n"

        # Let block
        nix << "let\n"
        nix << "  rubyVersion = \"${ruby.version.majMin}.0\";\n"
        nix << "  arch = stdenv.hostPlatform.system;\n"
        nix << "  bundle_path = \"ruby/${rubyVersion}\";\n"

        has_gem_path = false
        if has_overlay
          emit_overlay_let(nix, name)
          has_gem_path = true  # overlay always defines gemPath
        elsif scan && (!scan.build_gem_deps.empty? || scan.is_rust)
          has_gem_path = emit_auto_build_gems_let(nix, scan)
        end

        nix << "in\n"
        nix << "stdenv.mkDerivation {\n"
        nix << "  pname = #{name.inspect};\n"
        nix << "  version = #{version.inspect};\n"
        nix << "  src = builtins.path {\n"
        nix << "    path = ./source;\n"
        nix << "    name = #{(key + "-source").inspect};\n"
        nix << "  };\n\n"

        # Build phase
        if has_ext
          emit_build_phase(nix, has_overlay: has_overlay, scan: scan, has_auto: has_auto,
                           has_gem_path: has_gem_path, auto_nix_deps: auto_nix_deps)
        else
          nix << "  dontBuild = true;\n"
        end

        nix << "  dontConfigure = true;\n\n"
        nix << "  passthru = { inherit bundle_path; };\n\n"

        # Install phase
        emit_install_phase(nix, name: name, version: version, key: key,
          has_ext: has_ext, has_overlay: has_overlay,
          require_paths: require_paths, executables: executables, bindir: bindir,
          source: source)

        nix << "}\n"
        nix
      end

      def emit_overlay_let(nix, name)
        nix << "  overlay = import ../../../../overlays/#{name}.nix { inherit pkgs ruby; };\n"
        nix << "  overlayDeps = if builtins.isList overlay then overlay else overlay.deps or [ ];\n"
        nix << "  overlayBuildGems =\n"
        nix << "    if builtins.isAttrs overlay && overlay ? buildGems then overlay.buildGems else [ ];\n"
        nix << "  overlayBuildPhase =\n"
        nix << "    if builtins.isAttrs overlay && overlay ? buildPhase then overlay.buildPhase else null;\n"
        nix << "  overlayBeforeBuild =\n"
        nix << "    if builtins.isAttrs overlay && overlay ? beforeBuild then overlay.beforeBuild else \"\";\n"
        nix << "  overlayAfterBuild =\n"
        nix << "    if builtins.isAttrs overlay && overlay ? afterBuild then overlay.afterBuild else \"\";\n"
        nix << "  overlayPostInstall =\n"
        nix << "    if builtins.isAttrs overlay && overlay ? postInstall then overlay.postInstall else \"\";\n"
        nix << "  overlayExtconfFlags =\n"
        nix << "    if builtins.isAttrs overlay && overlay ? extconfFlags then overlay.extconfFlags else \"\";\n"
        nix << "  gemPath = builtins.concatStringsSep \":\" (map (g: \"${g}/${g.bundle_path}\") overlayBuildGems);\n"
      end

      def emit_auto_build_gems_let(nix, scan)
        resolved = []

        if scan.is_rust
          rb_sys_dir = File.join(@project.output_dir, "rb_sys")
          if Dir.exist?(rb_sys_dir)
            versions = version_dirs(rb_sys_dir)
            unless versions.empty?
              nix << "  rb_sys = import ../../rb_sys/#{versions.last} { inherit lib stdenv ruby; };\n"
              resolved << "rb_sys"
            end
          end
        end

        scan.build_gem_deps.reject { |g| g == "rb_sys" }.each do |gdep|
          gdep_dir = File.join(@project.output_dir, gdep)
          if Dir.exist?(gdep_dir)
            versions = version_dirs(gdep_dir)
            unless versions.empty?
              varname = gdep.tr("-", "_")
              nix << "  #{varname} = import ../../#{gdep}/#{versions.last} { inherit lib stdenv ruby; };\n"
              resolved << varname
            end
          end
        end

        unless resolved.empty?
          expr = resolved.map { |g| "\"${#{g}}/${#{g}.bundle_path}\"" }.join(" ")
          nix << "  gemPath = builtins.concatStringsSep \":\" [ #{expr} ];\n"
        end

        !resolved.empty?
      end

      # Resolve all scanner signals into a deduplicated list of nixpkgs attrs.
      # Merges pkg_config, have_library, dir_config, C #include, and build tool signals.
      def resolve_nix_deps(scan)
        nix_deps = Set.new

        # 1. pkg_config names — highest confidence
        scan.pkg_configs.each do |pc|
          nix_deps << PKG_CONFIG_TO_NIX.fetch(pc, pc)
        end

        # 2. have_library names — map known ones
        scan.libraries.each do |lib|
          nix_pkg = LIBRARY_TO_NIX[lib]
          nix_deps << nix_pkg if nix_pkg
        end

        # 3. dir_config names — map known ones
        scan.dir_configs.each do |dc|
          nix_pkg = DIR_CONFIG_TO_NIX[dc]
          nix_deps << nix_pkg if nix_pkg
        end

        # 4. C #include prefixes — lowest confidence fallback
        scan.c_includes.each do |inc|
          nix_pkg = C_INCLUDE_TO_NIX[inc]
          nix_deps << nix_pkg if nix_pkg
        end

        # 5. Build tools (perl, cmake, etc.)
        scan.build_tools.each do |tool|
          nix_pkg = BUILD_TOOL_TO_NIX[tool]
          nix_deps << nix_pkg if nix_pkg
        end

        # Add pkg-config utility if any pkg_config() calls were found
        nix_deps << "pkg-config" unless scan.pkg_configs.empty?

        nix_deps.to_a.sort
      end

      # Determine which build gem deps are missing from the gemset and
      # need to be installed at build time via `gem install`.
      def missing_build_gems(scan)
        return [] unless scan
        scan.build_gem_deps.select do |gdep|
          !Dir.exist?(File.join(@project.output_dir, gdep))
        end
      end

      def version_dirs(dir)
        Dir.children(dir)
          .select { |d| d != "default.nix" && File.directory?(File.join(dir, d)) && !d.start_with?("git-") }
          .sort_by { |v| Gem::Version.new(v) rescue Gem::Version.new("0") }
      end

      DEFAULT_BUILD_LINES = [
        'for extconf in $(find ext -name extconf.rb 2>/dev/null); do',
        '  dir=$(dirname "$extconf")',
        '  echo "Building extension in $dir"',
        '  (cd "$dir" && ruby extconf.rb $extconfFlags && make -j$NIX_BUILD_CORES)',
        'done',
        'for makefile in $(find ext -name Makefile 2>/dev/null); do',
        '  dir=$(dirname "$makefile")',
        '  target_name=$(sed -n \'s/^TARGET = //p\' "$makefile")',
        '  target_prefix=$(sed -n \'s/^target_prefix = //p\' "$makefile")',
        '  for ext in so bundle; do',
        '    if [ -n "$target_name" ] && [ -f "$dir/$target_name.$ext" ]; then',
        '      mkdir -p "lib$target_prefix"',
        '      cp "$dir/$target_name.$ext" "lib$target_prefix/$target_name.$ext"',
        '      echo "Installed $dir/$target_name.$ext -> lib$target_prefix/$target_name.$ext"',
        '    fi',
        '  done',
        'done',
      ].freeze

      def emit_build_phase(nix, has_overlay:, scan:, has_auto:, has_gem_path: false, auto_nix_deps: [])
        if has_overlay
          nix << "  nativeBuildInputs = [ ruby ] ++ overlayDeps;\n\n"
          nix << "  buildPhase =\n"
          nix << "    if overlayBuildPhase != null then\n"
          nix << "      (if gemPath != \"\" then \"export GEM_PATH=${gemPath}\\n\" else \"\") + overlayBuildPhase\n"
          nix << "    else\n"
          nix << "      ''\n"
          nix << "        ${lib.optionalString (gemPath != \"\") \"export GEM_PATH=${gemPath}\"}\n"
          nix << "        extconfFlags=\"${overlayExtconfFlags}\"\n"
          nix << "        ${overlayBeforeBuild}\n"
          DEFAULT_BUILD_LINES.each { |l| nix << "        #{l}\n" }
          nix << "        ${overlayAfterBuild}\n"
          nix << "      '';\n\n"
        elsif scan&.is_rust
          nix << "  nativeBuildInputs = [ ruby pkgs.cargo pkgs.rustc pkgs.llvmPackages.libclang ];\n\n"
          nix << "  buildPhase = ''\n"
          nix << "    export GEM_PATH=${gemPath}\n" if has_gem_path
          nix << "    export CARGO_HOME=\"$TMPDIR/cargo\"\n"
          nix << "    mkdir -p \"$CARGO_HOME\"\n"
          nix << "    export LIBCLANG_PATH=\"${pkgs.llvmPackages.libclang.lib}/lib\"\n"
          nix << "    clang_version=$(ls \"${pkgs.llvmPackages.libclang.lib}/lib/clang/\" | head -1)\n"
          nix << "    export BINDGEN_EXTRA_CLANG_ARGS=\"-isystem ${pkgs.llvmPackages.libclang.lib}/lib/clang/$clang_version/include\"\n"
          nix << "    export CC=\"${pkgs.stdenv.cc}/bin/cc\"\n"
          nix << "    export CXX=\"${pkgs.stdenv.cc}/bin/c++\"\n"
          nix << "    extconfFlags=\"#{scan.system_lib_flags || ""}\"\n"
          DEFAULT_BUILD_LINES.each { |l| nix << "    #{l}\n" }
          nix << "  '';\n\n"
        elsif has_auto && scan
          # Resolved nix deps from all signals (pkg_config, have_library, dir_config, C includes, build tools)
          deps = auto_nix_deps.map { |d| "pkgs.#{d}" }
          nix << "  nativeBuildInputs = [ ruby #{deps.join(" ")} ];\n\n"
          missing_gems = missing_build_gems(scan)
          nix << "  buildPhase = ''\n"
          nix << "    export GEM_PATH=${gemPath}\n" if has_gem_path
          unless missing_gems.empty?
            nix << "    # Auto-install build-time gem deps not in the gemset\n"
            nix << "    export GEM_HOME=\"$TMPDIR/gems\"\n"
            nix << "    export GEM_PATH=\"$GEM_HOME''${GEM_PATH:+:$GEM_PATH}\"\n"
            missing_gems.each do |g|
              nix << "    ${ruby}/bin/gem install #{g} --no-document --install-dir \"$GEM_HOME\" 2>/dev/null || true\n"
            end
          end
          nix << "    extconfFlags=\"#{scan.system_lib_flags || ""}\"\n"
          DEFAULT_BUILD_LINES.each { |l| nix << "    #{l}\n" }
          nix << "  '';\n\n"
        else
          nix << "  nativeBuildInputs = [ ruby ];\n\n"
          nix << "  buildPhase = ''\n"
          nix << "    extconfFlags=\"\"\n"
          DEFAULT_BUILD_LINES.each { |l| nix << "    #{l}\n" }
          nix << "  '';\n\n"
        end
      end

      def emit_install_phase(nix, name:, version:, key:, has_ext:, has_overlay:,
                             require_paths:, executables:, bindir:, source:)
        si = SH
        hd = HD

        has_prebuilt = !has_ext && !Dir.glob(File.join(source, "**", "*.{so,bundle}")).empty?
        needs_platform = has_ext || has_prebuilt

        nix << "  installPhase = ''\n"
        nix << "#{si}local dest=$out/${bundle_path}\n"
        nix << "#{si}mkdir -p $dest/gems/#{key}\n"
        nix << "#{si}cp -r . $dest/gems/#{key}/\n"

        if needs_platform
          nix << "#{si}local extdir=$dest/extensions/${arch}/${rubyVersion}/#{key}\n"
          nix << "#{si}mkdir -p $extdir\n"
          nix << "#{si}find . \\( -name '*.so' -o -name '*.bundle' \\) -path '*/lib/*' | while read so; do\n"
          nix << "#{si}  cp \"$so\" \"$extdir/\"\n"
          nix << "#{si}done\n"
          nix << "#{si}local cpu=\"${stdenv.hostPlatform.parsed.cpu.name}\"\n"
          nix << "#{si}if [ \"$cpu\" = \"aarch64\" ]; then cpu=\"arm64\"; fi\n"
          nix << "#{si}local gp=\"$cpu-${stdenv.hostPlatform.parsed.kernel.name}\"\n"
          nix << "#{si}if [ \"${stdenv.hostPlatform.parsed.abi.name}\" != \"unknown\" ]; then\n"
          nix << "#{si}  gp=\"$gp-${stdenv.hostPlatform.parsed.abi.name}\"\n"
          nix << "#{si}fi\n"
          nix << "#{si}ln -s #{key} $dest/gems/#{key}-$gp\n"
          nix << "#{si}ln -s #{key} $dest/extensions/${arch}/${rubyVersion}/#{key}-$gp\n"
          nix << "#{si}if [ \"${stdenv.hostPlatform.parsed.kernel.name}\" = \"darwin\" ]; then\n"
          nix << "#{si}  ln -sf #{key} $dest/gems/#{key}-universal-darwin\n"
          nix << "#{si}  ln -sf #{key} $dest/extensions/${arch}/${rubyVersion}/#{key}-universal-darwin\n"
          nix << "#{si}fi\n"
        end

        # Gemspec
        nix << "#{si}mkdir -p $dest/specifications\n"
        rp = require_paths.map { |p| "\"#{p}\"" }.join(", ")
        nix << "#{si}cat > $dest/specifications/#{key}.gemspec <<'EOF'\n"
        nix << "#{hd}Gem::Specification.new do |s|\n"
        nix << "#{hd}  s.name = #{name.inspect}\n"
        nix << "#{hd}  s.version = #{version.inspect}\n"
        nix << "#{hd}  s.summary = #{name.inspect}\n"
        nix << "#{hd}  s.require_paths = [#{rp}]\n"
        unless executables.empty?
          nix << "#{hd}  s.bindir = #{bindir.inspect}\n"
          nix << "#{hd}  s.executables = [#{executables.map(&:inspect).join(", ")}]\n"
        end
        nix << "#{hd}  s.files = []\n"
        nix << "#{hd}end\n"
        nix << "#{hd}EOF\n"

        if needs_platform
          nix << "#{si}cat > $dest/specifications/#{key}-$gp.gemspec <<PLATSPEC\n"
          nix << "#{hd}Gem::Specification.new do |s|\n"
          nix << "#{hd}  s.name = #{name.inspect}\n"
          nix << "#{hd}  s.version = #{version.inspect}\n"
          nix << "#{hd}  s.platform = \"$gp\"\n"
          nix << "#{hd}  s.summary = #{name.inspect}\n"
          nix << "#{hd}  s.require_paths = [#{rp}]\n"
          unless executables.empty?
            nix << "#{hd}  s.bindir = #{bindir.inspect}\n"
            nix << "#{hd}  s.executables = [#{executables.map(&:inspect).join(", ")}]\n"
          end
          nix << "#{hd}  s.files = []\n"
          nix << "#{hd}end\n"
          nix << "#{hd}PLATSPEC\n"

          nix << "#{si}if [ \"${stdenv.hostPlatform.parsed.kernel.name}\" = \"darwin\" ]; then\n"
          nix << "#{si}  cat > $dest/specifications/#{key}-universal-darwin.gemspec <<'UNISPEC'\n"
          nix << "#{hd}Gem::Specification.new do |s|\n"
          nix << "#{hd}  s.name = #{name.inspect}\n"
          nix << "#{hd}  s.version = #{version.inspect}\n"
          nix << "#{hd}  s.platform = \"universal-darwin\"\n"
          nix << "#{hd}  s.summary = #{name.inspect}\n"
          nix << "#{hd}  s.require_paths = [#{rp}]\n"
          unless executables.empty?
            nix << "#{hd}  s.bindir = #{bindir.inspect}\n"
            nix << "#{hd}  s.executables = [#{executables.map(&:inspect).join(", ")}]\n"
          end
          nix << "#{hd}  s.files = []\n"
          nix << "#{hd}end\n"
          nix << "#{hd}UNISPEC\n"
          nix << "#{si}fi\n"
        end

        unless executables.empty?
          nix << "#{si}mkdir -p $dest/bin\n"
          executables.each do |exe|
            nix << "#{si}cat > $dest/bin/#{exe} <<'BINSTUB'\n"
            nix << "#{hd}#!/usr/bin/env ruby\n"
            nix << "#{hd}require \"rubygems\"\n"
            nix << "#{hd}load Gem.bin_path(#{name.inspect}, #{exe.inspect}, #{version.inspect})\n"
            nix << "#{hd}BINSTUB\n"
            nix << "#{si}chmod +x $dest/bin/#{exe}\n"
          end
        end

        nix << "#{si}${overlayPostInstall}\n" if has_overlay
        nix << "  '';\n"
      end

      # ── Git repo derivations ──────────────────────────────────────────

      def generate_git_derivations
        # Parse all gemset files for GIT sources via Scint
        repos = {}
        mat = @project.materializer
        Dir.glob(File.join(@project.gemsets_dir, "*.gemset")).each do |f|
          lockdata = @project.parse_lockfile(f)
          classified = mat.classify(lockdata)
          classified[:git].each do |key, repo|
            repos[key] ||= repo
          end
        end

        return if repos.empty?

        si = SH
        hd = HD
        generated = 0

        repos.each do |repo_key, repo|
          # Find source dir — try each gem name
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

          # Check for missing gemspecs
          missing_gemspecs = repo[:gems].select do |g|
            !File.exist?(File.join(source_dir, "#{g[:name]}.gemspec")) &&
              !File.exist?(File.join(source_dir, g[:name], "#{g[:name]}.gemspec"))
          end

          gnix = +""
          gnix << BANNER
          gnix << "# Git: #{repo[:base]} @ #{repo[:shortrev]}\n"
          gnix << "# URI: #{repo[:uri]}\n"
          gnix << "# Gems: #{repo[:gems].map { |g| g[:name] }.join(", ")}\n#\n"
          gnix << "{\n  lib,\n  stdenv,\n  ruby,\n}:\nlet\n"
          gnix << "  rubyVersion = \"${ruby.version.majMin}.0\";\n"
          gnix << "  bundle_path = \"ruby/${rubyVersion}\";\n"
          gnix << "in\nstdenv.mkDerivation {\n"
          gnix << "  pname = #{repo[:base].inspect};\n"
          gnix << "  version = #{repo[:shortrev].inspect};\n"
          gnix << "  src = builtins.path {\n    path = ./source;\n"
          gnix << "    name = #{(repo_key + "-source").inspect};\n  };\n\n"
          gnix << "  dontBuild = true;\n  dontConfigure = true;\n\n"
          gnix << "  passthru = { inherit bundle_path; };\n\n"
          gnix << "  installPhase = ''\n"
          gnix << "#{si}local dest=$out/${bundle_path}/bundler/gems/#{repo_key}\n"
          gnix << "#{si}mkdir -p $dest\n"
          gnix << "#{si}cp -r . $dest/\n"

          missing_gemspecs.each do |g|
            gnix << "#{si}cat > $dest/#{g[:name]}.gemspec <<'EOF'\n"
            gnix << "#{hd}Gem::Specification.new do |s|\n"
            gnix << "#{hd}  s.name = #{g[:name].inspect}\n"
            gnix << "#{hd}  s.version = #{g[:version].inspect}\n"
            gnix << "#{hd}  s.summary = #{g[:name].inspect}\n"
            gnix << "#{hd}  s.require_paths = [\"lib\"]\n"
            gnix << "#{hd}  s.files = []\n"
            gnix << "#{hd}end\n#{hd}EOF\n"
          end

          gnix << "  '';\n}\n"
          File.write(File.join(git_dir, "default.nix"), gnix)
          generated += 1

          # Patch or create selector
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
          # Git-only selector
          sel = +""
          sel << BANNER
          sel << "# #{repo[:base]} (git only)\n#\n"
          sel << "{\n  lib,\n  stdenv,\n  ruby,\n"
          sel << "  pkgs ? null,\n  version ? null,\n  git ? { },\n}:\nlet\n"
          sel << "  versions = { };\n\n  gitRevs = {\n"
          sel << "    #{repo[:shortrev].inspect} = import ./git-#{repo[:shortrev]} { inherit lib stdenv ruby; };\n"
          sel << "  };\nin\n"
          sel << "if git ? rev then\n"
          sel << "  gitRevs.\${git.rev}\n"
          sel << "    or (throw \"#{repo[:base]}: unknown git rev '\${git.rev}'\")\n"
          sel << "else if version != null then\n"
          sel << "  throw \"#{repo[:base]}: no rubygems versions, only git\"\n"
          sel << "else\n"
          sel << "  throw \"#{repo[:base]}: specify git.rev\"\n"

          FileUtils.mkdir_p(File.dirname(selector_path))
          File.write(selector_path, sel)

          # Add git-only gem to catalogue
          @gems_by_name[repo[:base]] ||= { versions: [], needs_pkgs: false }
        end
      end

      # ── Selectors: nix/gem/<name>/default.nix ────────────────────────

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
          latest = versions.last
          needs_pkgs = info[:needs_pkgs]

          sel = +""
          sel << BANNER
          sel << "# #{name}\n#\n"
          sel << "# Versions: #{versions.join(", ")}\n#\n"
          sel << "{\n  lib,\n  stdenv,\n  ruby,\n"
          sel << "  pkgs ? null,\n  version ? #{latest.inspect},\n  git ? { },\n}:\n"
          sel << "let\n  versions = {\n"

          versions.each do |v|
            if needs_pkgs
              sel << "    #{v.inspect} = import ./#{v} { inherit lib stdenv ruby pkgs; };\n"
            else
              sel << "    #{v.inspect} = import ./#{v} { inherit lib stdenv ruby; };\n"
            end
          end

          sel << "  };\n\n  gitRevs = {\n  };\nin\n"
          sel << "if git ? rev then\n"
          sel << "  gitRevs.\${git.rev}\n"
          sel << "    or (throw \"#{name}: unknown git rev '\${git.rev}'\")\n"
          sel << "else\n"
          sel << "  versions.\${version}\n"
          sel << "    or (throw \"#{name}: unknown version '\${version}'\")\n"

          File.write(File.join(@project.output_dir, name, "default.nix"), sel)
        end

        UI.done "#{@gems_by_name.size} selectors"
      end

      # ── Catalogue: nix/modules/gem.nix ───────────────────────────────

      def generate_catalogue
        top = +""
        top << BANNER
        top << "# #{@gems_by_name.size} gems\n#\n"
        top << "{ pkgs, ruby }:\n\nlet\n"
        top << "  inherit (pkgs) lib stdenv;\n"
        top << "  gem =\n    name: args:\n"
        top << "    import (../gem + \"/\${name}\") (\n"
        top << "      { inherit lib stdenv ruby pkgs; }\n"
        top << "      // args\n"
        top << "    );\n"
        top << "in\n{\n"

        @gems_by_name.keys.sort.each do |name|
          top << "  #{name.inspect} = args: gem #{name.inspect} args;\n"
        end

        top << "}\n"

        FileUtils.mkdir_p(@project.modules_dir)
        File.write(File.join(@project.modules_dir, "gem.nix"), top)
        UI.wrote "nix/modules/gem.nix"
      end
    end
  end
end
