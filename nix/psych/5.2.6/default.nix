#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# psych 5.2.6
#
{ lib, stdenv, ruby, pkgs }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
  overlay = import ../../../overlays/psych.nix { inherit pkgs ruby; };
  overlayDeps = if builtins.isList overlay then overlay else overlay.deps or [];
  overlayBuildPhase = if builtins.isAttrs overlay && overlay ? buildPhase then overlay.buildPhase else null;
in

stdenv.mkDerivation {
  pname = "psych";
  version = "5.2.6";
  src = builtins.path { path = ./source; name = "psych-5.2.6-source"; };

  nativeBuildInputs = [ ruby ] ++ overlayDeps;

  buildPhase = if overlayBuildPhase != null then overlayBuildPhase else ''
    for extconf in $(find ext -name extconf.rb 2>/dev/null); do
      dir=$(dirname "$extconf")
      echo "Building extension in $dir"
      (cd "$dir" && ruby extconf.rb && make -j$NIX_BUILD_CORES)
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
  '';

  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/psych-5.2.6
    cp -r . $dest/gems/psych-5.2.6/
    local extdir=$dest/extensions/${arch}/${rubyVersion}/psych-5.2.6
    mkdir -p $extdir
    find . -name '*.so' -path '*/lib/*' | while read so; do
      cp "$so" "$extdir/"
    done
    local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
    if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
      gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
    fi
    ln -s psych-5.2.6 $dest/gems/psych-5.2.6-$gp
    ln -s psych-5.2.6 $dest/extensions/${arch}/${rubyVersion}/psych-5.2.6-$gp
    mkdir -p $dest/specifications
    cat > $dest/specifications/psych-5.2.6.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "psych"
  s.version = "5.2.6"
  s.summary = "psych"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
    cat > $dest/specifications/psych-5.2.6-$gp.gemspec <<PLATSPEC
Gem::Specification.new do |s|
  s.name = "psych"
  s.version = "5.2.6"
  s.platform = "$gp"
  s.summary = "psych"
  s.require_paths = ["lib"]
  s.files = []
end
PLATSPEC
  '';
}
