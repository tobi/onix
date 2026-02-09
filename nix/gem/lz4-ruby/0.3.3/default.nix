#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# lz4-ruby 0.3.3
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
  pname = "lz4-ruby";
  version = "0.3.3";
  src = builtins.path {
    path = ./source;
    name = "lz4-ruby-0.3.3-source";
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
        mkdir -p $dest/gems/lz4-ruby-0.3.3
        cp -r . $dest/gems/lz4-ruby-0.3.3/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/lz4-ruby-0.3.3
        mkdir -p $extdir
        find . -name '*.so' -path '*/lib/*' | while read so; do
          cp "$so" "$extdir/"
        done
        local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
        if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
          gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
        fi
        ln -s lz4-ruby-0.3.3 $dest/gems/lz4-ruby-0.3.3-$gp
        ln -s lz4-ruby-0.3.3 $dest/extensions/${arch}/${rubyVersion}/lz4-ruby-0.3.3-$gp
        mkdir -p $dest/specifications
        cat > $dest/specifications/lz4-ruby-0.3.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "lz4-ruby"
      s.version = "0.3.3"
      s.summary = "lz4-ruby"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/lz4-ruby-0.3.3-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "lz4-ruby"
      s.version = "0.3.3"
      s.platform = "$gp"
      s.summary = "lz4-ruby"
      s.require_paths = ["lib"]
      s.files = []
    end
    PLATSPEC
  '';
}
