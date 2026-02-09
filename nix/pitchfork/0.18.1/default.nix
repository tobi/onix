# pitchfork 0.18.1
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "pitchfork";
  version = "0.18.1";
  src = builtins.path { path = ./source; name = "pitchfork-0.18.1-source"; };

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
    mkdir -p $dest/gems/pitchfork-0.18.1
    cp -r . $dest/gems/pitchfork-0.18.1/
    local extdir=$dest/extensions/${arch}/${rubyVersion}/pitchfork-0.18.1
    mkdir -p $extdir
    find . -name '*.so' -path '*/lib/*' | while read so; do
      cp "$so" "$extdir/"
    done
    local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
    if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
      gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
    fi
    ln -s pitchfork-0.18.1 $dest/gems/pitchfork-0.18.1-$gp
    ln -s pitchfork-0.18.1 $dest/extensions/${arch}/${rubyVersion}/pitchfork-0.18.1-$gp
    mkdir -p $dest/specifications
    cat > $dest/specifications/pitchfork-0.18.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "pitchfork"
  s.version = "0.18.1"
  s.summary = "pitchfork"
  s.require_paths = ["lib"]
  s.bindir = "exe"
  s.executables = ["pitchfork"]
  s.files = []
end
EOF
    cat > $dest/specifications/pitchfork-0.18.1-$gp.gemspec <<PLATSPEC
Gem::Specification.new do |s|
  s.name = "pitchfork"
  s.version = "0.18.1"
  s.platform = "$gp"
  s.summary = "pitchfork"
  s.require_paths = ["lib"]
  s.bindir = "exe"
  s.executables = ["pitchfork"]
  s.files = []
end
PLATSPEC
    mkdir -p $dest/bin
    cat > $dest/bin/pitchfork <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("pitchfork", "pitchfork", "0.18.1")
BINSTUB
    chmod +x $dest/bin/pitchfork
  '';
}
