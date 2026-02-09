#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# byebug 12.0.0
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
  pname = "byebug";
  version = "12.0.0";
  src = builtins.path {
    path = ./source;
    name = "byebug-12.0.0-source";
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
        mkdir -p $dest/gems/byebug-12.0.0
        cp -r . $dest/gems/byebug-12.0.0/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/byebug-12.0.0
        mkdir -p $extdir
        find . -name '*.so' -path '*/lib/*' | while read so; do
          cp "$so" "$extdir/"
        done
        local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
        if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
          gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
        fi
        ln -s byebug-12.0.0 $dest/gems/byebug-12.0.0-$gp
        ln -s byebug-12.0.0 $dest/extensions/${arch}/${rubyVersion}/byebug-12.0.0-$gp
        mkdir -p $dest/specifications
        cat > $dest/specifications/byebug-12.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "byebug"
      s.version = "12.0.0"
      s.summary = "byebug"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["byebug"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/byebug-12.0.0-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "byebug"
      s.version = "12.0.0"
      s.platform = "$gp"
      s.summary = "byebug"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["byebug"]
      s.files = []
    end
    PLATSPEC
        mkdir -p $dest/bin
        cat > $dest/bin/byebug <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("byebug", "byebug", "12.0.0")
    BINSTUB
        chmod +x $dest/bin/byebug
  '';
}
