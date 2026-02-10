# frozen_string_literal: true

require "json"
require "fileutils"
require "pathname"
require "set"

module Gemset2Nix
  module Commands
    class Update
      include NixWriter

      def run(argv)
        @project = Project.new
        @meta = @project.load_metadata
        @overlays = Set.new(@project.overlays)

        $stderr.puts "#{@meta.size} gems in cache (#{@overlays.size} overlays)"

        generate_derivations
        generate_selectors
        generate_catalogue
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
          has_auto = scan&.native?
          needs_pkgs = has_overlay || (scan && (scan.is_rust || !scan.pkg_configs.empty? || !scan.libraries.empty?))

          nix = build_derivation(
            name: name, version: version, key: key,
            has_ext: has_ext, has_overlay: has_overlay,
            scan: scan, has_auto: has_auto, needs_pkgs: needs_pkgs,
            require_paths: require_paths, executables: executables, bindir: bindir,
            source: source
          )

          File.write(File.join(gem_dir, "default.nix"), nix)
          generated += 1
        end

        $stderr.puts "#{generated} derivations"
      end

      def build_derivation(name:, version:, key:, has_ext:, has_overlay:, scan:, has_auto:,
                           needs_pkgs:, require_paths:, executables:, bindir:, source:)
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

        if has_overlay
          emit_overlay_let(nix, name)
        elsif scan && (!scan.build_gem_deps.empty? || scan.is_rust)
          emit_auto_build_gems_let(nix, scan)
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
          emit_build_phase(nix, has_overlay: has_overlay, scan: scan, has_auto: has_auto)
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

      def emit_build_phase(nix, has_overlay:, scan:, has_auto:)
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
          nix << "    export GEM_PATH=${gemPath}\n"
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
          # Auto-detected pkg_config names become pkgs.* deps
          deps = (scan.pkg_configs + scan.libraries).uniq.map { |d| "pkgs.#{d}" }
          deps << "pkgs.pkg-config" unless scan.pkg_configs.empty?
          nix << "  nativeBuildInputs = [ ruby #{deps.join(" ")} ];\n\n"
          nix << "  buildPhase = ''\n"
          has_gem_path = !scan.build_gem_deps.empty?
          nix << "    export GEM_PATH=${gemPath}\n" if has_gem_path
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
              if scan.native?
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

        $stderr.puts "#{@gems_by_name.size} selectors"
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
        $stderr.puts "-> nix/modules/gem.nix"
      end
    end
  end
end
