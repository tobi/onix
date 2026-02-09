#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rmagick 6.1.3
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
  overlay = import ../../../../overlays/rmagick.nix { inherit pkgs ruby; };
  overlayDeps = if builtins.isList overlay then overlay else overlay.deps or [ ];
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
in
stdenv.mkDerivation {
  pname = "rmagick";
  version = "6.1.3";
  src = builtins.path {
    path = ./source;
    name = "rmagick-6.1.3-source";
  };

  nativeBuildInputs = [ ruby ] ++ overlayDeps;

  buildPhase =
    if overlayBuildPhase != null then
      overlayBuildPhase
    else
      ''
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
          if [ -n "$target_name" ] && [ -f "$dir/$target_name.so" ]; then
            mkdir -p "lib$target_prefix"
            cp "$dir/$target_name.so" "lib$target_prefix/$target_name.so"
            echo "Installed $dir/$target_name.so -> lib$target_prefix/$target_name.so"
          fi
        done
        ${overlayAfterBuild}
      '';

  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rmagick-6.1.3
        cp -r . $dest/gems/rmagick-6.1.3/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/rmagick-6.1.3
        mkdir -p $extdir
        find . -name '*.so' -path '*/lib/*' | while read so; do
          cp "$so" "$extdir/"
        done
        local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
        if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
          gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
        fi
        ln -s rmagick-6.1.3 $dest/gems/rmagick-6.1.3-$gp
        ln -s rmagick-6.1.3 $dest/extensions/${arch}/${rubyVersion}/rmagick-6.1.3-$gp
        mkdir -p $dest/specifications
        cat > $dest/specifications/rmagick-6.1.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rmagick"
      s.version = "6.1.3"
      s.summary = "rmagick"
      s.require_paths = ["lib", "ext"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/rmagick-6.1.3-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "rmagick"
      s.version = "6.1.3"
      s.platform = "$gp"
      s.summary = "rmagick"
      s.require_paths = ["lib", "ext"]
      s.files = []
    end
    PLATSPEC
        ${overlayPostInstall}
  '';
}
