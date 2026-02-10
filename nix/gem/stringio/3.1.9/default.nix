#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# stringio 3.1.9
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
  pname = "stringio";
  version = "3.1.9";
  src = builtins.path {
    path = ./source;
    name = "stringio-3.1.9-source";
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
      for ext in so bundle; do
        if [ -n "$target_name" ] && [ -f "$dir/$target_name.$ext" ]; then
          mkdir -p "lib$target_prefix"
          cp "$dir/$target_name.$ext" "lib$target_prefix/$target_name.$ext"
          echo "Installed $dir/$target_name.$ext -> lib$target_prefix/$target_name.$ext"
        fi
      done
    done
  '';

  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/stringio-3.1.9
        cp -r . $dest/gems/stringio-3.1.9/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/stringio-3.1.9
        mkdir -p $extdir
        find . \( -name '*.so' -o -name '*.bundle' \) -path '*/lib/*' | while read so; do
          cp "$so" "$extdir/"
        done
        local cpu="${stdenv.hostPlatform.parsed.cpu.name}"
        if [ "$cpu" = "aarch64" ]; then cpu="arm64"; fi
        local gp="$cpu-${stdenv.hostPlatform.parsed.kernel.name}"
        if [ "${stdenv.hostPlatform.parsed.abi.name}" != "unknown" ]; then
          gp="$gp-${stdenv.hostPlatform.parsed.abi.name}"
        fi
        ln -s stringio-3.1.9 $dest/gems/stringio-3.1.9-$gp
        ln -s stringio-3.1.9 $dest/extensions/${arch}/${rubyVersion}/stringio-3.1.9-$gp
        if [ "${stdenv.hostPlatform.parsed.kernel.name}" = "darwin" ]; then
          ln -sf stringio-3.1.9 $dest/gems/stringio-3.1.9-universal-darwin
          ln -sf stringio-3.1.9 $dest/extensions/${arch}/${rubyVersion}/stringio-3.1.9-universal-darwin
        fi
        mkdir -p $dest/specifications
        cat > $dest/specifications/stringio-3.1.9.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "stringio"
      s.version = "3.1.9"
      s.summary = "stringio"
      s.require_paths = ["/home/tobi/.local/share/mise/installs/ruby/3.4.7/lib/ruby/gems/3.4.0/extensions/x86_64-linux/3.4.0-static/stringio-3.1.9", "lib"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/stringio-3.1.9-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "stringio"
      s.version = "3.1.9"
      s.platform = "$gp"
      s.summary = "stringio"
      s.require_paths = ["/home/tobi/.local/share/mise/installs/ruby/3.4.7/lib/ruby/gems/3.4.0/extensions/x86_64-linux/3.4.0-static/stringio-3.1.9", "lib"]
      s.files = []
    end
    PLATSPEC
        if [ "${stdenv.hostPlatform.parsed.kernel.name}" = "darwin" ]; then
          cat > $dest/specifications/stringio-3.1.9-universal-darwin.gemspec <<'UNISPEC'
    Gem::Specification.new do |s|
      s.name = "stringio"
      s.version = "3.1.9"
      s.platform = "universal-darwin"
      s.summary = "stringio"
      s.require_paths = ["/home/tobi/.local/share/mise/installs/ruby/3.4.7/lib/ruby/gems/3.4.0/extensions/x86_64-linux/3.4.0-static/stringio-3.1.9", "lib"]
      s.files = []
    end
    UNISPEC
        fi
  '';
}
