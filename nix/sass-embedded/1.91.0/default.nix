# sass-embedded 1.91.0
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "sass-embedded";
  version = "1.91.0";
  src = builtins.path { path = ./source; name = "sass-embedded-1.91.0-source"; };

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
    mkdir -p $dest/gems/sass-embedded-1.91.0
    cp -r . $dest/gems/sass-embedded-1.91.0/
    local extdir=$dest/extensions/${arch}/${rubyVersion}/sass-embedded-1.91.0
    mkdir -p $extdir
    find . -name '*.so' -path '*/lib/*' | while read so; do
      cp "$so" "$extdir/"
    done
    local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
    if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
      gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
    fi
    ln -s sass-embedded-1.91.0 $dest/gems/sass-embedded-1.91.0-$gp
    ln -s sass-embedded-1.91.0 $dest/extensions/${arch}/${rubyVersion}/sass-embedded-1.91.0-$gp
    mkdir -p $dest/specifications
    cat > $dest/specifications/sass-embedded-1.91.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "sass-embedded"
  s.version = "1.91.0"
  s.summary = "sass-embedded"
  s.require_paths = ["lib"]
  s.bindir = "exe"
  s.executables = ["sass"]
  s.files = []
end
EOF
    cat > $dest/specifications/sass-embedded-1.91.0-$gp.gemspec <<PLATSPEC
Gem::Specification.new do |s|
  s.name = "sass-embedded"
  s.version = "1.91.0"
  s.platform = "$gp"
  s.summary = "sass-embedded"
  s.require_paths = ["lib"]
  s.bindir = "exe"
  s.executables = ["sass"]
  s.files = []
end
PLATSPEC
    mkdir -p $dest/bin
    cat > $dest/bin/sass <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("sass-embedded", "sass", "1.91.0")
BINSTUB
    chmod +x $dest/bin/sass
  '';
}
