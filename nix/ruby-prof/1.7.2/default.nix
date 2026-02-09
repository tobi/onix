#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-prof 1.7.2
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "ruby-prof";
  version = "1.7.2";
  src = builtins.path { path = ./source; name = "ruby-prof-1.7.2-source"; };

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
    mkdir -p $dest/gems/ruby-prof-1.7.2
    cp -r . $dest/gems/ruby-prof-1.7.2/
    local extdir=$dest/extensions/${arch}/${rubyVersion}/ruby-prof-1.7.2
    mkdir -p $extdir
    find . -name '*.so' -path '*/lib/*' | while read so; do
      cp "$so" "$extdir/"
    done
    local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
    if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
      gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
    fi
    ln -s ruby-prof-1.7.2 $dest/gems/ruby-prof-1.7.2-$gp
    ln -s ruby-prof-1.7.2 $dest/extensions/${arch}/${rubyVersion}/ruby-prof-1.7.2-$gp
    mkdir -p $dest/specifications
    cat > $dest/specifications/ruby-prof-1.7.2.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "ruby-prof"
  s.version = "1.7.2"
  s.summary = "ruby-prof"
  s.require_paths = ["lib"]
  s.bindir = "bin"
  s.executables = ["ruby-prof", "ruby-prof-check-trace"]
  s.files = []
end
EOF
    cat > $dest/specifications/ruby-prof-1.7.2-$gp.gemspec <<PLATSPEC
Gem::Specification.new do |s|
  s.name = "ruby-prof"
  s.version = "1.7.2"
  s.platform = "$gp"
  s.summary = "ruby-prof"
  s.require_paths = ["lib"]
  s.bindir = "bin"
  s.executables = ["ruby-prof", "ruby-prof-check-trace"]
  s.files = []
end
PLATSPEC
    mkdir -p $dest/bin
    cat > $dest/bin/ruby-prof <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("ruby-prof", "ruby-prof", "1.7.2")
BINSTUB
    chmod +x $dest/bin/ruby-prof
    cat > $dest/bin/ruby-prof-check-trace <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("ruby-prof", "ruby-prof-check-trace", "1.7.2")
BINSTUB
    chmod +x $dest/bin/ruby-prof-check-trace
  '';
}
