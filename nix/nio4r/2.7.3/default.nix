# nio4r 2.7.3
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "nio4r";
  version = "2.7.3";
  src = builtins.path { path = ./source; name = "nio4r-2.7.3-source"; };

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
    mkdir -p $dest/gems/nio4r-2.7.3
    cp -r . $dest/gems/nio4r-2.7.3/
    local extdir=$dest/extensions/${arch}/${rubyVersion}/nio4r-2.7.3
    mkdir -p $extdir
    find . -name '*.so' -path '*/lib/*' | while read so; do
      cp "$so" "$extdir/"
    done
    local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
    if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
      gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
    fi
    ln -s nio4r-2.7.3 $dest/gems/nio4r-2.7.3-$gp
    ln -s nio4r-2.7.3 $dest/extensions/${arch}/${rubyVersion}/nio4r-2.7.3-$gp
    mkdir -p $dest/specifications
    cat > $dest/specifications/nio4r-2.7.3.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "nio4r"
  s.version = "2.7.3"
  s.summary = "nio4r"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
    cat > $dest/specifications/nio4r-2.7.3-$gp.gemspec <<PLATSPEC
Gem::Specification.new do |s|
  s.name = "nio4r"
  s.version = "2.7.3"
  s.platform = "$gp"
  s.summary = "nio4r"
  s.require_paths = ["lib"]
  s.files = []
end
PLATSPEC
  '';
}
