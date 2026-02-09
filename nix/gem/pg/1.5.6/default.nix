#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pg 1.5.6
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
  overlay = import ../../../../overlays/pg.nix { inherit pkgs ruby; };
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
  pname = "pg";
  version = "1.5.6";
  src = builtins.path {
    path = ./source;
    name = "pg-1.5.6-source";
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
        mkdir -p $dest/gems/pg-1.5.6
        cp -r . $dest/gems/pg-1.5.6/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/pg-1.5.6
        mkdir -p $extdir
        find . -name '*.so' -path '*/lib/*' | while read so; do
          cp "$so" "$extdir/"
        done
        local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
        if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
          gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
        fi
        ln -s pg-1.5.6 $dest/gems/pg-1.5.6-$gp
        ln -s pg-1.5.6 $dest/extensions/${arch}/${rubyVersion}/pg-1.5.6-$gp
        mkdir -p $dest/specifications
        cat > $dest/specifications/pg-1.5.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "pg"
      s.version = "1.5.6"
      s.summary = "pg"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/pg-1.5.6-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "pg"
      s.version = "1.5.6"
      s.platform = "$gp"
      s.summary = "pg"
      s.require_paths = ["lib"]
      s.files = []
    end
    PLATSPEC
        ${overlayPostInstall}
  '';
}
