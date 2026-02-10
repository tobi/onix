#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# puma 7.2.0
#
{
  lib,
  stdenv,
  ruby,
  pkgs,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  bundle_path = "ruby/${rubyVersion}";
  overlay = import ../../../../overlays/puma.nix { inherit pkgs ruby; };
  overlayDeps = if builtins.isList overlay then overlay else overlay.deps or [ ];
  overlayBuildGems =
    if builtins.isAttrs overlay && overlay ? buildGems then overlay.buildGems else [ ];
  overlayBuildPhase =
    if builtins.isAttrs overlay && overlay ? buildPhase then overlay.buildPhase else null;
  overlayBeforeBuild =
    if builtins.isAttrs overlay && overlay ? beforeBuild then overlay.beforeBuild else "";
  overlayAfterBuild =
    if builtins.isAttrs overlay && overlay ? afterBuild then overlay.afterBuild else "";
  overlayPostInstall =
    if builtins.isAttrs overlay && overlay ? postInstall then overlay.postInstall else "";
  overlayExtconfFlags =
    if builtins.isAttrs overlay && overlay ? extconfFlags then overlay.extconfFlags else "";
  gemPath = builtins.concatStringsSep ":" (map (g: "${g}/${g.bundle_path}") overlayBuildGems);
in
stdenv.mkDerivation {
  pname = "puma";
  version = "7.2.0";
  src = builtins.path {
    path = ./source;
    name = "puma-7.2.0-source";
  };

  nativeBuildInputs = [ ruby ] ++ overlayDeps;

  buildPhase =
    if overlayBuildPhase != null then
      (if gemPath != "" then "export GEM_PATH=${gemPath}\n" else "") + overlayBuildPhase
    else
      ''
        ${lib.optionalString (gemPath != "") "export GEM_PATH=${gemPath}"}
        extconfFlags="${overlayExtconfFlags}"
        ${overlayBeforeBuild}
        for extconf in $(find ext -name extconf.rb 2>/dev/null); do
          dir=$(dirname "$extconf")
          echo "Building extension in $dir"
          (cd "$dir" && ruby extconf.rb $extconfFlags && make -j$NIX_BUILD_CORES)
        done
        for makefile in $(find ext -name Makefile 2>/dev/null); do
          dir=$(dirname "$makefile")
          target_name=$(sed -n 's/^TARGET = //p' "$makefile")
          target_prefix=$(sed -n 's/^target_prefix = //p' "$makefile")
          for ext in so bundle; do
            if [ -n "$target_name" ] && [ -f "$dir/$target_name.$ext" ]; then
              mkdir -p "lib$target_prefix"
              cp "$dir/$target_name.$ext" "lib$target_prefix/$target_name.$ext"
              echo "Installed $dir/$target_name.$ext -> lib$target_prefix/$target_name.$ext"
            fi
          done
        done
        ${overlayAfterBuild}
      '';

  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/puma-7.2.0
        cp -r . $dest/gems/puma-7.2.0/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/puma-7.2.0
        mkdir -p $extdir
        find . \( -name '*.so' -o -name '*.bundle' \) -path '*/lib/*' | while read so; do
          cp "$so" "$extdir/"
        done
        local cpu="${stdenv.hostPlatform.parsed.cpu.name}"
        if [ "$cpu" = "aarch64" ]; then cpu="arm64"; fi
        local gp="$cpu-${stdenv.hostPlatform.parsed.kernel.name}"
        if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
          gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
        fi
        ln -s puma-7.2.0 $dest/gems/puma-7.2.0-$gp
        ln -s puma-7.2.0 $dest/extensions/${arch}/${rubyVersion}/puma-7.2.0-$gp
        if [ "${stdenv.hostPlatform.parsed.kernel.name}" = "darwin" ]; then
          ln -sf puma-7.2.0 $dest/gems/puma-7.2.0-universal-darwin
          ln -sf puma-7.2.0 $dest/extensions/${arch}/${rubyVersion}/puma-7.2.0-universal-darwin
        fi
        mkdir -p $dest/specifications
        cat > $dest/specifications/puma-7.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "puma"
      s.version = "7.2.0"
      s.summary = "puma"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["puma", "pumactl"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/puma-7.2.0-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "puma"
      s.version = "7.2.0"
      s.platform = "$gp"
      s.summary = "puma"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["puma", "pumactl"]
      s.files = []
    end
    PLATSPEC
        if [ "${stdenv.hostPlatform.parsed.kernel.name}" = "darwin" ]; then
          cat > $dest/specifications/puma-7.2.0-universal-darwin.gemspec <<'UNISPEC'
    Gem::Specification.new do |s|
      s.name = "puma"
      s.version = "7.2.0"
      s.platform = "universal-darwin"
      s.summary = "puma"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["puma", "pumactl"]
      s.files = []
    end
    UNISPEC
        fi
        mkdir -p $dest/bin
        cat > $dest/bin/puma <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("puma", "puma", "7.2.0")
    BINSTUB
        chmod +x $dest/bin/puma
        cat > $dest/bin/pumactl <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("puma", "pumactl", "7.2.0")
    BINSTUB
        chmod +x $dest/bin/pumactl
        ${overlayPostInstall}
  '';
}
