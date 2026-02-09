#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# commonmarker 0.23.10
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "commonmarker";
  version = "0.23.10";
  src = builtins.path { path = ./source; name = "commonmarker-0.23.10-source"; };

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
    mkdir -p $dest/gems/commonmarker-0.23.10
    cp -r . $dest/gems/commonmarker-0.23.10/
    local extdir=$dest/extensions/${arch}/${rubyVersion}/commonmarker-0.23.10
    mkdir -p $extdir
    find . -name '*.so' -path '*/lib/*' | while read so; do
      cp "$so" "$extdir/"
    done
    local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
    if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
      gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
    fi
    ln -s commonmarker-0.23.10 $dest/gems/commonmarker-0.23.10-$gp
    ln -s commonmarker-0.23.10 $dest/extensions/${arch}/${rubyVersion}/commonmarker-0.23.10-$gp
    mkdir -p $dest/specifications
    cat > $dest/specifications/commonmarker-0.23.10.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "commonmarker"
  s.version = "0.23.10"
  s.summary = "commonmarker"
  s.require_paths = ["lib", "ext"]
  s.bindir = "bin"
  s.executables = ["commonmarker"]
  s.files = []
end
EOF
    cat > $dest/specifications/commonmarker-0.23.10-$gp.gemspec <<PLATSPEC
Gem::Specification.new do |s|
  s.name = "commonmarker"
  s.version = "0.23.10"
  s.platform = "$gp"
  s.summary = "commonmarker"
  s.require_paths = ["lib", "ext"]
  s.bindir = "bin"
  s.executables = ["commonmarker"]
  s.files = []
end
PLATSPEC
    mkdir -p $dest/bin
    cat > $dest/bin/commonmarker <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("commonmarker", "commonmarker", "0.23.10")
BINSTUB
    chmod +x $dest/bin/commonmarker
  '';
}
