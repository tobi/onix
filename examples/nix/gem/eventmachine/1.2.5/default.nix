#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# eventmachine 1.2.5
# auto-detected: pkg_config=[]
#
{
  lib,
  stdenv,
  ruby,
  pkgs,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  bundle_path = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "eventmachine";
  version = "1.2.5";
  src = builtins.path {
    path = ./source;
    name = "eventmachine-1.2.5-source";
  };

  nativeBuildInputs = [ ruby pkgs.openssl ];

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
        mkdir -p $dest/gems/eventmachine-1.2.5
        cp -r . $dest/gems/eventmachine-1.2.5/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/eventmachine-1.2.5
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
        ln -s eventmachine-1.2.5 $dest/gems/eventmachine-1.2.5-$gp
        ln -s eventmachine-1.2.5 $dest/extensions/${arch}/${rubyVersion}/eventmachine-1.2.5-$gp
        if [ "${stdenv.hostPlatform.parsed.kernel.name}" = "darwin" ]; then
          ln -sf eventmachine-1.2.5 $dest/gems/eventmachine-1.2.5-universal-darwin
          ln -sf eventmachine-1.2.5 $dest/extensions/${arch}/${rubyVersion}/eventmachine-1.2.5-universal-darwin
        fi
        mkdir -p $dest/specifications
        cat > $dest/specifications/eventmachine-1.2.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "eventmachine"
      s.version = "1.2.5"
      s.summary = "eventmachine"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/eventmachine-1.2.5-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "eventmachine"
      s.version = "1.2.5"
      s.platform = "$gp"
      s.summary = "eventmachine"
      s.require_paths = ["lib"]
      s.files = []
    end
    PLATSPEC
        if [ "${stdenv.hostPlatform.parsed.kernel.name}" = "darwin" ]; then
          cat > $dest/specifications/eventmachine-1.2.5-universal-darwin.gemspec <<'UNISPEC'
    Gem::Specification.new do |s|
      s.name = "eventmachine"
      s.version = "1.2.5"
      s.platform = "universal-darwin"
      s.summary = "eventmachine"
      s.require_paths = ["lib"]
      s.files = []
    end
    UNISPEC
        fi
  '';
}
