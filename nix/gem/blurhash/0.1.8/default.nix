#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# blurhash 0.1.8
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
  pname = "blurhash";
  version = "0.1.8";
  src = builtins.path {
    path = ./source;
    name = "blurhash-0.1.8-source";
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
        mkdir -p $dest/gems/blurhash-0.1.8
        cp -r . $dest/gems/blurhash-0.1.8/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/blurhash-0.1.8
        mkdir -p $extdir
        find . -name '*.so' -path '*/lib/*' | while read so; do
          cp "$so" "$extdir/"
        done
        local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
        if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
          gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
        fi
        ln -s blurhash-0.1.8 $dest/gems/blurhash-0.1.8-$gp
        ln -s blurhash-0.1.8 $dest/extensions/${arch}/${rubyVersion}/blurhash-0.1.8-$gp
        mkdir -p $dest/specifications
        cat > $dest/specifications/blurhash-0.1.8.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "blurhash"
      s.version = "0.1.8"
      s.summary = "blurhash"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/blurhash-0.1.8-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "blurhash"
      s.version = "0.1.8"
      s.platform = "$gp"
      s.summary = "blurhash"
      s.require_paths = ["lib"]
      s.files = []
    end
    PLATSPEC
  '';
}
