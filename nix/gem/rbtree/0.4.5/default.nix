#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rbtree 0.4.5
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
  pname = "rbtree";
  version = "0.4.5";
  src = builtins.path {
    path = ./source;
    name = "rbtree-0.4.5-source";
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
        mkdir -p $dest/gems/rbtree-0.4.5
        cp -r . $dest/gems/rbtree-0.4.5/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/rbtree-0.4.5
        mkdir -p $extdir
        find . -name '*.so' -path '*/lib/*' | while read so; do
          cp "$so" "$extdir/"
        done
        local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
        if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
          gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
        fi
        ln -s rbtree-0.4.5 $dest/gems/rbtree-0.4.5-$gp
        ln -s rbtree-0.4.5 $dest/extensions/${arch}/${rubyVersion}/rbtree-0.4.5-$gp
        mkdir -p $dest/specifications
        cat > $dest/specifications/rbtree-0.4.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rbtree"
      s.version = "0.4.5"
      s.summary = "rbtree"
      s.require_paths = ["/home/tobi/.local/share/mise/installs/ruby/3.4.7/lib/ruby/gems/3.4.0/extensions/x86_64-linux/3.4.0-static/rbtree-0.4.5", "lib"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/rbtree-0.4.5-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "rbtree"
      s.version = "0.4.5"
      s.platform = "$gp"
      s.summary = "rbtree"
      s.require_paths = ["/home/tobi/.local/share/mise/installs/ruby/3.4.7/lib/ruby/gems/3.4.0/extensions/x86_64-linux/3.4.0-static/rbtree-0.4.5", "lib"]
      s.files = []
    end
    PLATSPEC
  '';
}
