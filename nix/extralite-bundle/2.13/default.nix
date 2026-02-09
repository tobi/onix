#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# extralite-bundle 2.13
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "extralite-bundle";
  version = "2.13";
  src = builtins.path { path = ./source; name = "extralite-bundle-2.13-source"; };

  nativeBuildInputs = [ ruby ];

  buildPhase = ''
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
    mkdir -p $dest/gems/extralite-bundle-2.13
    cp -r . $dest/gems/extralite-bundle-2.13/
    local extdir=$dest/extensions/${arch}/${rubyVersion}/extralite-bundle-2.13
    mkdir -p $extdir
    find . -name '*.so' -path '*/lib/*' | while read so; do
      cp "$so" "$extdir/"
    done
    local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
    if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
      gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
    fi
    ln -s extralite-bundle-2.13 $dest/gems/extralite-bundle-2.13-$gp
    ln -s extralite-bundle-2.13 $dest/extensions/${arch}/${rubyVersion}/extralite-bundle-2.13-$gp
    mkdir -p $dest/specifications
    cat > $dest/specifications/extralite-bundle-2.13.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "extralite-bundle"
  s.version = "2.13"
  s.summary = "extralite-bundle"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
    cat > $dest/specifications/extralite-bundle-2.13-$gp.gemspec <<PLATSPEC
Gem::Specification.new do |s|
  s.name = "extralite-bundle"
  s.version = "2.13"
  s.platform = "$gp"
  s.summary = "extralite-bundle"
  s.require_paths = ["lib"]
  s.files = []
end
PLATSPEC
  '';
}
