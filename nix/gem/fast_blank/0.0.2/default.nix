#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fast_blank 0.0.2
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
  pname = "fast_blank";
  version = "0.0.2";
  src = builtins.path {
    path = ./source;
    name = "fast_blank-0.0.2-source";
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
        mkdir -p $dest/gems/fast_blank-0.0.2
        cp -r . $dest/gems/fast_blank-0.0.2/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/fast_blank-0.0.2
        mkdir -p $extdir
        find . -name '*.so' -path '*/lib/*' | while read so; do
          cp "$so" "$extdir/"
        done
        local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
        if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
          gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
        fi
        ln -s fast_blank-0.0.2 $dest/gems/fast_blank-0.0.2-$gp
        ln -s fast_blank-0.0.2 $dest/extensions/${arch}/${rubyVersion}/fast_blank-0.0.2-$gp
        mkdir -p $dest/specifications
        cat > $dest/specifications/fast_blank-0.0.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fast_blank"
      s.version = "0.0.2"
      s.summary = "fast_blank"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/fast_blank-0.0.2-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "fast_blank"
      s.version = "0.0.2"
      s.platform = "$gp"
      s.summary = "fast_blank"
      s.require_paths = ["lib"]
      s.files = []
    end
    PLATSPEC
  '';
}
