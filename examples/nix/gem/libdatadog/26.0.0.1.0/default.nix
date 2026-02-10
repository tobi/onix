#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# libdatadog 26.0.0.1.0
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
  pname = "libdatadog";
  version = "26.0.0.1.0";
  src = builtins.path {
    path = ./source;
    name = "libdatadog-26.0.0.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/libdatadog-26.0.0.1.0
        cp -r . $dest/gems/libdatadog-26.0.0.1.0/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/libdatadog-26.0.0.1.0
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
        ln -s libdatadog-26.0.0.1.0 $dest/gems/libdatadog-26.0.0.1.0-$gp
        ln -s libdatadog-26.0.0.1.0 $dest/extensions/${arch}/${rubyVersion}/libdatadog-26.0.0.1.0-$gp
        if [ "${stdenv.hostPlatform.parsed.kernel.name}" = "darwin" ]; then
          ln -sf libdatadog-26.0.0.1.0 $dest/gems/libdatadog-26.0.0.1.0-universal-darwin
          ln -sf libdatadog-26.0.0.1.0 $dest/extensions/${arch}/${rubyVersion}/libdatadog-26.0.0.1.0-universal-darwin
        fi
        mkdir -p $dest/specifications
        cat > $dest/specifications/libdatadog-26.0.0.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "libdatadog"
      s.version = "26.0.0.1.0"
      s.summary = "libdatadog"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/libdatadog-26.0.0.1.0-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "libdatadog"
      s.version = "26.0.0.1.0"
      s.platform = "$gp"
      s.summary = "libdatadog"
      s.require_paths = ["lib"]
      s.files = []
    end
    PLATSPEC
        if [ "${stdenv.hostPlatform.parsed.kernel.name}" = "darwin" ]; then
          cat > $dest/specifications/libdatadog-26.0.0.1.0-universal-darwin.gemspec <<'UNISPEC'
    Gem::Specification.new do |s|
      s.name = "libdatadog"
      s.version = "26.0.0.1.0"
      s.platform = "universal-darwin"
      s.summary = "libdatadog"
      s.require_paths = ["lib"]
      s.files = []
    end
    UNISPEC
        fi
  '';
}
