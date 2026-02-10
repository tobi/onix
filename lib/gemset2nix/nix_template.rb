# frozen_string_literal: true

module Gemset2Nix
  # Generates Nix expression strings for gem derivations, selectors,
  # git repos, and the catalogue. Pure string output — no filesystem.
  class NixTemplate
    include NixWriter

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

    # ── Per-gem derivation ──────────────────────────────────────────

    def derivation(name:, version:, has_ext:, has_overlay:, scan:, has_auto:,
                   needs_pkgs:, auto_nix_deps:, require_paths:, executables:,
                   bindir:, has_prebuilt:, auto_build_gems:, gem_path_entries:)
      key = "#{name}-#{version}"
      nix = +""

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
      args = %w[lib stdenv ruby]
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
        overlay_let(nix, name)
        has_gem_path = true
      elsif !gem_path_entries.empty?
        auto_build_gems_let(nix, gem_path_entries)
        has_gem_path = true
      end

      nix << "in\n"
      nix << "stdenv.mkDerivation {\n"
      nix << "  pname = #{name.inspect};\n"
      nix << "  version = #{version.inspect};\n"
      nix << "  src = builtins.path {\n"
      nix << "    path = ./source;\n"
      nix << "    name = #{(key + "-source").inspect};\n"
      nix << "  };\n\n"

      if has_ext
        build_phase(nix, has_overlay: has_overlay, scan: scan, has_auto: has_auto,
                    has_gem_path: has_gem_path, auto_nix_deps: auto_nix_deps,
                    auto_build_gems: auto_build_gems)
      else
        nix << "  dontBuild = true;\n"
      end

      nix << "  dontConfigure = true;\n\n"
      nix << "  passthru = { inherit bundle_path; };\n\n"

      install_phase(nix, name: name, version: version, key: key,
                    has_ext: has_ext, has_overlay: has_overlay,
                    has_prebuilt: has_prebuilt,
                    require_paths: require_paths, executables: executables, bindir: bindir)

      nix << "}\n"
      nix
    end

    # ── Git repo derivation ─────────────────────────────────────────

    def git_derivation(repo_key:, repo:, missing_gemspecs:)
      nix = +""
      nix << BANNER
      nix << "# Git: #{repo[:base]} @ #{repo[:shortrev]}\n"
      nix << "# URI: #{repo[:uri]}\n"
      nix << "# Gems: #{repo[:gems].map { |g| g[:name] }.join(", ")}\n#\n"
      nix << "{\n  lib,\n  stdenv,\n  ruby,\n}:\nlet\n"
      nix << "  rubyVersion = \"${ruby.version.majMin}.0\";\n"
      nix << "  bundle_path = \"ruby/${rubyVersion}\";\n"
      nix << "in\nstdenv.mkDerivation {\n"
      nix << "  pname = #{repo[:base].inspect};\n"
      nix << "  version = #{repo[:shortrev].inspect};\n"
      nix << "  src = builtins.path {\n    path = ./source;\n"
      nix << "    name = #{(repo_key + "-source").inspect};\n  };\n\n"
      nix << "  dontBuild = true;\n  dontConfigure = true;\n\n"
      nix << "  passthru = { inherit bundle_path; };\n\n"
      nix << "  installPhase = ''\n"
      nix << "#{SH}local dest=$out/${bundle_path}/bundler/gems/#{repo_key}\n"
      nix << "#{SH}mkdir -p $dest\n"
      nix << "#{SH}cp -r . $dest/\n"

      missing_gemspecs.each do |g|
        nix << "#{SH}cat > $dest/#{g[:name]}.gemspec <<'EOF'\n"
        nix << "#{HD}Gem::Specification.new do |s|\n"
        nix << "#{HD}  s.name = #{g[:name].inspect}\n"
        nix << "#{HD}  s.version = #{g[:version].inspect}\n"
        nix << "#{HD}  s.summary = #{g[:name].inspect}\n"
        nix << "#{HD}  s.require_paths = [\"lib\"]\n"
        nix << "#{HD}  s.files = []\n"
        nix << "#{HD}end\n#{HD}EOF\n"
      end

      nix << "  '';\n}\n"
      nix
    end

    # ── Selector ────────────────────────────────────────────────────

    def selector(name:, versions:, needs_pkgs:, git_revs: [])
      latest = versions.last
      nix = +""
      nix << BANNER
      nix << "# #{name}\n#\n"
      nix << "# Versions: #{versions.join(", ")}\n#\n"
      nix << "{\n  lib,\n  stdenv,\n  ruby,\n"
      nix << "  pkgs ? null,\n  version ? #{latest.inspect},\n  git ? { },\n}:\n"
      nix << "let\n  versions = {\n"

      versions.each do |v|
        if needs_pkgs
          nix << "    #{v.inspect} = import ./#{v} { inherit lib stdenv ruby pkgs; };\n"
        else
          nix << "    #{v.inspect} = import ./#{v} { inherit lib stdenv ruby; };\n"
        end
      end

      nix << "  };\n\n  gitRevs = {\n"
      git_revs.each do |rev|
        nix << "    #{rev.inspect} = import ./git-#{rev} { inherit lib stdenv ruby; };\n"
      end
      nix << "  };\nin\n"
      nix << "if git ? rev then\n"
      nix << "  gitRevs.\${git.rev}\n"
      nix << "    or (throw \"#{name}: unknown git rev '\${git.rev}'\")\n"
      nix << "else\n"
      nix << "  versions.\${version}\n"
      nix << "    or (throw \"#{name}: unknown version '\${version}'\")\n"
      nix
    end

    def git_only_selector(name:, shortrev:)
      nix = +""
      nix << BANNER
      nix << "# #{name} (git only)\n#\n"
      nix << "{\n  lib,\n  stdenv,\n  ruby,\n"
      nix << "  pkgs ? null,\n  version ? null,\n  git ? { },\n}:\nlet\n"
      nix << "  versions = { };\n\n  gitRevs = {\n"
      nix << "    #{shortrev.inspect} = import ./git-#{shortrev} { inherit lib stdenv ruby; };\n"
      nix << "  };\nin\n"
      nix << "if git ? rev then\n"
      nix << "  gitRevs.\${git.rev}\n"
      nix << "    or (throw \"#{name}: unknown git rev '\${git.rev}'\")\n"
      nix << "else if version != null then\n"
      nix << "  throw \"#{name}: no rubygems versions, only git\"\n"
      nix << "else\n"
      nix << "  throw \"#{name}: specify git.rev\"\n"
      nix
    end

    # ── Catalogue ───────────────────────────────────────────────────

    def catalogue(gem_names:)
      nix = +""
      nix << BANNER
      nix << "# #{gem_names.size} gems\n#\n"
      nix << "{ pkgs, ruby }:\n\nlet\n"
      nix << "  inherit (pkgs) lib stdenv;\n"
      nix << "  gem =\n    name: args:\n"
      nix << "    import (../gem + \"/\${name}\") (\n"
      nix << "      { inherit lib stdenv ruby pkgs; }\n"
      nix << "      // args\n"
      nix << "    );\n"
      nix << "in\n{\n"

      gem_names.sort.each do |name|
        nix << "  #{name.inspect} = args: gem #{name.inspect} args;\n"
      end

      nix << "}\n"
      nix
    end

    private

    # ── Let-block fragments ─────────────────────────────────────────

    def overlay_let(nix, name)
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

    def auto_build_gems_let(nix, entries)
      # entries: [{ varname:, import_path: }]
      entries.each do |e|
        nix << "  #{e[:varname]} = import #{e[:import_path]} { inherit lib stdenv ruby; };\n"
      end
      expr = entries.map { |e| "\"${#{e[:varname]}}/${#{e[:varname]}.bundle_path}\"" }.join(" ")
      nix << "  gemPath = builtins.concatStringsSep \":\" [ #{expr} ];\n"
    end

    # ── Build phase ─────────────────────────────────────────────────

    def build_phase(nix, has_overlay:, scan:, has_auto:, has_gem_path:,
                    auto_nix_deps:, auto_build_gems:)
      if has_overlay
        build_phase_overlay(nix)
      elsif scan&.is_rust
        build_phase_rust(nix, scan: scan, has_gem_path: has_gem_path)
      elsif has_auto && scan
        build_phase_auto(nix, scan: scan, has_gem_path: has_gem_path,
                         auto_nix_deps: auto_nix_deps, auto_build_gems: auto_build_gems)
      else
        build_phase_default(nix)
      end
    end

    def build_phase_overlay(nix)
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
    end

    def build_phase_rust(nix, scan:, has_gem_path:)
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
    end

    def build_phase_auto(nix, scan:, has_gem_path:, auto_nix_deps:, auto_build_gems:)
      deps = auto_nix_deps.map { |d| "pkgs.#{d}" }
      nix << "  nativeBuildInputs = [ ruby #{deps.join(" ")} ];\n\n"
      nix << "  buildPhase = ''\n"
      nix << "    export GEM_PATH=${gemPath}\n" if has_gem_path
      unless auto_build_gems.empty?
        nix << "    # Auto-install build-time gem deps not in the gemset\n"
        nix << "    export GEM_HOME=\"$TMPDIR/gems\"\n"
        nix << "    export GEM_PATH=\"$GEM_HOME''${GEM_PATH:+:$GEM_PATH}\"\n"
        auto_build_gems.each do |g|
          nix << "    ${ruby}/bin/gem install #{g} --no-document --install-dir \"$GEM_HOME\" 2>/dev/null || true\n"
        end
      end
      nix << "    extconfFlags=\"#{scan.system_lib_flags || ""}\"\n"
      DEFAULT_BUILD_LINES.each { |l| nix << "    #{l}\n" }
      nix << "  '';\n\n"
    end

    def build_phase_default(nix)
      nix << "  nativeBuildInputs = [ ruby ];\n\n"
      nix << "  buildPhase = ''\n"
      nix << "    extconfFlags=\"\"\n"
      DEFAULT_BUILD_LINES.each { |l| nix << "    #{l}\n" }
      nix << "  '';\n\n"
    end

    # ── Install phase ───────────────────────────────────────────────

    def install_phase(nix, name:, version:, key:, has_ext:, has_overlay:,
                      has_prebuilt:, require_paths:, executables:, bindir:)
      needs_platform = has_ext || has_prebuilt
      rp = require_paths.map { |p| "\"#{p}\"" }.join(", ")

      nix << "  installPhase = ''\n"
      nix << "#{SH}local dest=$out/${bundle_path}\n"
      nix << "#{SH}mkdir -p $dest/gems/#{key}\n"
      nix << "#{SH}cp -r . $dest/gems/#{key}/\n"

      platform_setup(nix, key) if needs_platform

      gemspec_block(nix, name: name, version: version, key: key, rp: rp,
                    executables: executables, bindir: bindir)

      if needs_platform
        platform_gemspec(nix, name: name, version: version, key: key, rp: rp,
                         executables: executables, bindir: bindir)
      end

      binstubs(nix, name: name, version: version, executables: executables) unless executables.empty?

      nix << "#{SH}${overlayPostInstall}\n" if has_overlay
      nix << "  '';\n"
    end

    def platform_setup(nix, key)
      nix << "#{SH}local extdir=$dest/extensions/${arch}/${rubyVersion}/#{key}\n"
      nix << "#{SH}mkdir -p $extdir\n"
      nix << "#{SH}find . \\( -name '*.so' -o -name '*.bundle' \\) -path '*/lib/*' | while read so; do\n"
      nix << "#{SH}  cp \"$so\" \"$extdir/\"\n"
      nix << "#{SH}done\n"
      nix << "#{SH}local cpu=\"${stdenv.hostPlatform.parsed.cpu.name}\"\n"
      nix << "#{SH}if [ \"$cpu\" = \"aarch64\" ]; then cpu=\"arm64\"; fi\n"
      nix << "#{SH}local gp=\"$cpu-${stdenv.hostPlatform.parsed.kernel.name}\"\n"
      nix << "#{SH}if [ \"${stdenv.hostPlatform.parsed.abi.name}\" != \"unknown\" ]; then\n"
      nix << "#{SH}  gp=\"$gp-${stdenv.hostPlatform.parsed.abi.name}\"\n"
      nix << "#{SH}fi\n"
      nix << "#{SH}ln -s #{key} $dest/gems/#{key}-$gp\n"
      nix << "#{SH}ln -s #{key} $dest/extensions/${arch}/${rubyVersion}/#{key}-$gp\n"
      nix << "#{SH}if [ \"${stdenv.hostPlatform.parsed.kernel.name}\" = \"darwin\" ]; then\n"
      nix << "#{SH}  ln -sf #{key} $dest/gems/#{key}-universal-darwin\n"
      nix << "#{SH}  ln -sf #{key} $dest/extensions/${arch}/${rubyVersion}/#{key}-universal-darwin\n"
      nix << "#{SH}fi\n"
    end

    def gemspec_block(nix, name:, version:, key:, rp:, executables:, bindir:)
      nix << "#{SH}mkdir -p $dest/specifications\n"
      nix << "#{SH}cat > $dest/specifications/#{key}.gemspec <<'EOF'\n"
      nix << "#{HD}Gem::Specification.new do |s|\n"
      nix << "#{HD}  s.name = #{name.inspect}\n"
      nix << "#{HD}  s.version = #{version.inspect}\n"
      nix << "#{HD}  s.summary = #{name.inspect}\n"
      nix << "#{HD}  s.require_paths = [#{rp}]\n"
      unless executables.empty?
        nix << "#{HD}  s.bindir = #{bindir.inspect}\n"
        nix << "#{HD}  s.executables = [#{executables.map(&:inspect).join(", ")}]\n"
      end
      nix << "#{HD}  s.files = []\n"
      nix << "#{HD}end\n"
      nix << "#{HD}EOF\n"
    end

    def platform_gemspec(nix, name:, version:, key:, rp:, executables:, bindir:)
      nix << "#{SH}cat > $dest/specifications/#{key}-$gp.gemspec <<PLATSPEC\n"
      nix << "#{HD}Gem::Specification.new do |s|\n"
      nix << "#{HD}  s.name = #{name.inspect}\n"
      nix << "#{HD}  s.version = #{version.inspect}\n"
      nix << "#{HD}  s.platform = \"$gp\"\n"
      nix << "#{HD}  s.summary = #{name.inspect}\n"
      nix << "#{HD}  s.require_paths = [#{rp}]\n"
      unless executables.empty?
        nix << "#{HD}  s.bindir = #{bindir.inspect}\n"
        nix << "#{HD}  s.executables = [#{executables.map(&:inspect).join(", ")}]\n"
      end
      nix << "#{HD}  s.files = []\n"
      nix << "#{HD}end\n"
      nix << "#{HD}PLATSPEC\n"

      nix << "#{SH}if [ \"${stdenv.hostPlatform.parsed.kernel.name}\" = \"darwin\" ]; then\n"
      nix << "#{SH}  cat > $dest/specifications/#{key}-universal-darwin.gemspec <<'UNISPEC'\n"
      nix << "#{HD}Gem::Specification.new do |s|\n"
      nix << "#{HD}  s.name = #{name.inspect}\n"
      nix << "#{HD}  s.version = #{version.inspect}\n"
      nix << "#{HD}  s.platform = \"universal-darwin\"\n"
      nix << "#{HD}  s.summary = #{name.inspect}\n"
      nix << "#{HD}  s.require_paths = [#{rp}]\n"
      unless executables.empty?
        nix << "#{HD}  s.bindir = #{bindir.inspect}\n"
        nix << "#{HD}  s.executables = [#{executables.map(&:inspect).join(", ")}]\n"
      end
      nix << "#{HD}  s.files = []\n"
      nix << "#{HD}end\n"
      nix << "#{HD}UNISPEC\n"
      nix << "#{SH}fi\n"
    end

    def binstubs(nix, name:, version:, executables:)
      nix << "#{SH}mkdir -p $dest/bin\n"
      executables.each do |exe|
        nix << "#{SH}cat > $dest/bin/#{exe} <<'BINSTUB'\n"
        nix << "#{HD}#!/usr/bin/env ruby\n"
        nix << "#{HD}require \"rubygems\"\n"
        nix << "#{HD}load Gem.bin_path(#{name.inspect}, #{exe.inspect}, #{version.inspect})\n"
        nix << "#{HD}BINSTUB\n"
        nix << "#{SH}chmod +x $dest/bin/#{exe}\n"
      end
    end
  end
end
