#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# raindrops 0.20.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "raindrops";
  version = "0.20.1";
  src = builtins.path { path = ./source; name = "raindrops-0.20.1-source"; };

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
    mkdir -p $dest/gems/raindrops-0.20.1
    cp -r . $dest/gems/raindrops-0.20.1/
    local extdir=$dest/extensions/${arch}/${rubyVersion}/raindrops-0.20.1
    mkdir -p $extdir
    find . -name '*.so' -path '*/lib/*' | while read so; do
      cp "$so" "$extdir/"
    done
    local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
    if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
      gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
    fi
    ln -s raindrops-0.20.1 $dest/gems/raindrops-0.20.1-$gp
    ln -s raindrops-0.20.1 $dest/extensions/${arch}/${rubyVersion}/raindrops-0.20.1-$gp
    mkdir -p $dest/specifications
    cat > $dest/specifications/raindrops-0.20.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "raindrops"
  s.version = "0.20.1"
  s.summary = "raindrops"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
    cat > $dest/specifications/raindrops-0.20.1-$gp.gemspec <<PLATSPEC
Gem::Specification.new do |s|
  s.name = "raindrops"
  s.version = "0.20.1"
  s.platform = "$gp"
  s.summary = "raindrops"
  s.require_paths = ["lib"]
  s.files = []
end
PLATSPEC
  '';
}
