#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rbs 3.9.5
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "rbs";
  version = "3.9.5";
  src = builtins.path {
    path = ./source;
    name = "rbs-3.9.5-source";
  };

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
        mkdir -p $dest/gems/rbs-3.9.5
        cp -r . $dest/gems/rbs-3.9.5/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/rbs-3.9.5
        mkdir -p $extdir
        find . -name '*.so' -path '*/lib/*' | while read so; do
          cp "$so" "$extdir/"
        done
        local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
        if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
          gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
        fi
        ln -s rbs-3.9.5 $dest/gems/rbs-3.9.5-$gp
        ln -s rbs-3.9.5 $dest/extensions/${arch}/${rubyVersion}/rbs-3.9.5-$gp
        mkdir -p $dest/specifications
        cat > $dest/specifications/rbs-3.9.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rbs"
      s.version = "3.9.5"
      s.summary = "rbs"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["rbs"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/rbs-3.9.5-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "rbs"
      s.version = "3.9.5"
      s.platform = "$gp"
      s.summary = "rbs"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["rbs"]
      s.files = []
    end
    PLATSPEC
        mkdir -p $dest/bin
        cat > $dest/bin/rbs <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rbs", "rbs", "3.9.5")
    BINSTUB
        chmod +x $dest/bin/rbs
  '';
}
