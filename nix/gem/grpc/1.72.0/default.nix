#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# grpc 1.72.0
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
  pname = "grpc";
  version = "1.72.0";
  src = builtins.path {
    path = ./source;
    name = "grpc-1.72.0-source";
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
        mkdir -p $dest/gems/grpc-1.72.0
        cp -r . $dest/gems/grpc-1.72.0/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/grpc-1.72.0
        mkdir -p $extdir
        find . -name '*.so' -path '*/lib/*' | while read so; do
          cp "$so" "$extdir/"
        done
        local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
        if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
          gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
        fi
        ln -s grpc-1.72.0 $dest/gems/grpc-1.72.0-$gp
        ln -s grpc-1.72.0 $dest/extensions/${arch}/${rubyVersion}/grpc-1.72.0-$gp
        mkdir -p $dest/specifications
        cat > $dest/specifications/grpc-1.72.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "grpc"
      s.version = "1.72.0"
      s.summary = "grpc"
      s.require_paths = ["src/ruby/lib", "src/ruby/bin", "src/ruby/pb"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/grpc-1.72.0-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "grpc"
      s.version = "1.72.0"
      s.platform = "$gp"
      s.summary = "grpc"
      s.require_paths = ["src/ruby/lib", "src/ruby/bin", "src/ruby/pb"]
      s.files = []
    end
    PLATSPEC
  '';
}
