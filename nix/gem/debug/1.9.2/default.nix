#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# debug 1.9.2
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  bundle_path = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "debug";
  version = "1.9.2";
  src = builtins.path {
    path = ./source;
    name = "debug-1.9.2-source";
  };

  nativeBuildInputs = [ ruby ];

  buildPhase = ''
    extconfFlags=""
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
  '';

  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/debug-1.9.2
        cp -r . $dest/gems/debug-1.9.2/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/debug-1.9.2
        mkdir -p $extdir
        find . -name '*.so' -path '*/lib/*' | while read so; do
          cp "$so" "$extdir/"
        done
        local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
        if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
          gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
        fi
        ln -s debug-1.9.2 $dest/gems/debug-1.9.2-$gp
        ln -s debug-1.9.2 $dest/extensions/${arch}/${rubyVersion}/debug-1.9.2-$gp
        mkdir -p $dest/specifications
        cat > $dest/specifications/debug-1.9.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "debug"
      s.version = "1.9.2"
      s.summary = "debug"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["rdbg"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/debug-1.9.2-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "debug"
      s.version = "1.9.2"
      s.platform = "$gp"
      s.summary = "debug"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["rdbg"]
      s.files = []
    end
    PLATSPEC
        mkdir -p $dest/bin
        cat > $dest/bin/rdbg <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("debug", "rdbg", "1.9.2")
    BINSTUB
        chmod +x $dest/bin/rdbg
  '';
}
