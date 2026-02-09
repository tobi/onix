#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# stringio 3.2.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "stringio";
  version = "3.2.0";
  src = builtins.path { path = ./source; name = "stringio-3.2.0-source"; };

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
    mkdir -p $dest/gems/stringio-3.2.0
    cp -r . $dest/gems/stringio-3.2.0/
    local extdir=$dest/extensions/${arch}/${rubyVersion}/stringio-3.2.0
    mkdir -p $extdir
    find . -name '*.so' -path '*/lib/*' | while read so; do
      cp "$so" "$extdir/"
    done
    local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
    if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
      gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
    fi
    ln -s stringio-3.2.0 $dest/gems/stringio-3.2.0-$gp
    ln -s stringio-3.2.0 $dest/extensions/${arch}/${rubyVersion}/stringio-3.2.0-$gp
    mkdir -p $dest/specifications
    cat > $dest/specifications/stringio-3.2.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "stringio"
  s.version = "3.2.0"
  s.summary = "stringio"
  s.require_paths = ["/home/tobi/.local/share/mise/installs/ruby/3.4.7/lib/ruby/gems/3.4.0/extensions/x86_64-linux/3.4.0-static/stringio-3.2.0", "lib"]
  s.files = []
end
EOF
    cat > $dest/specifications/stringio-3.2.0-$gp.gemspec <<PLATSPEC
Gem::Specification.new do |s|
  s.name = "stringio"
  s.version = "3.2.0"
  s.platform = "$gp"
  s.summary = "stringio"
  s.require_paths = ["/home/tobi/.local/share/mise/installs/ruby/3.4.7/lib/ruby/gems/3.4.0/extensions/x86_64-linux/3.4.0-static/stringio-3.2.0", "lib"]
  s.files = []
end
PLATSPEC
  '';
}
