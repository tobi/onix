#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# kostya-sigar 2.0.11
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
  pname = "kostya-sigar";
  version = "2.0.11";
  src = builtins.path {
    path = ./source;
    name = "kostya-sigar-2.0.11-source";
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
        mkdir -p $dest/gems/kostya-sigar-2.0.11
        cp -r . $dest/gems/kostya-sigar-2.0.11/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/kostya-sigar-2.0.11
        mkdir -p $extdir
        find . -name '*.so' -path '*/lib/*' | while read so; do
          cp "$so" "$extdir/"
        done
        local gp="${stdenv.hostPlatform.parsed.cpu.name}-${stdenv.hostPlatform.parsed.kernel.name}"
        if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
          gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
        fi
        ln -s kostya-sigar-2.0.11 $dest/gems/kostya-sigar-2.0.11-$gp
        ln -s kostya-sigar-2.0.11 $dest/extensions/${arch}/${rubyVersion}/kostya-sigar-2.0.11-$gp
        mkdir -p $dest/specifications
        cat > $dest/specifications/kostya-sigar-2.0.11.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "kostya-sigar"
      s.version = "2.0.11"
      s.summary = "kostya-sigar"
      s.require_paths = ["/home/tobi/.local/share/mise/installs/ruby/3.4.7/lib/ruby/gems/3.4.0/extensions/x86_64-linux/3.4.0-static/kostya-sigar-2.0.11", "lib"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/kostya-sigar-2.0.11-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "kostya-sigar"
      s.version = "2.0.11"
      s.platform = "$gp"
      s.summary = "kostya-sigar"
      s.require_paths = ["/home/tobi/.local/share/mise/installs/ruby/3.4.7/lib/ruby/gems/3.4.0/extensions/x86_64-linux/3.4.0-static/kostya-sigar-2.0.11", "lib"]
      s.files = []
    end
    PLATSPEC
  '';
}
