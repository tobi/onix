#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# libddwaf 1.24.1.0.3
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
  pname = "libddwaf";
  version = "1.24.1.0.3";
  src = builtins.path {
    path = ./source;
    name = "libddwaf-1.24.1.0.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/libddwaf-1.24.1.0.3
        cp -r . $dest/gems/libddwaf-1.24.1.0.3/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/libddwaf-1.24.1.0.3
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
        ln -s libddwaf-1.24.1.0.3 $dest/gems/libddwaf-1.24.1.0.3-$gp
        ln -s libddwaf-1.24.1.0.3 $dest/extensions/${arch}/${rubyVersion}/libddwaf-1.24.1.0.3-$gp
        if [ "${stdenv.hostPlatform.parsed.kernel.name}" = "darwin" ]; then
          ln -sf libddwaf-1.24.1.0.3 $dest/gems/libddwaf-1.24.1.0.3-universal-darwin
          ln -sf libddwaf-1.24.1.0.3 $dest/extensions/${arch}/${rubyVersion}/libddwaf-1.24.1.0.3-universal-darwin
        fi
        mkdir -p $dest/specifications
        cat > $dest/specifications/libddwaf-1.24.1.0.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "libddwaf"
      s.version = "1.24.1.0.3"
      s.summary = "libddwaf"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/libddwaf-1.24.1.0.3-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "libddwaf"
      s.version = "1.24.1.0.3"
      s.platform = "$gp"
      s.summary = "libddwaf"
      s.require_paths = ["lib"]
      s.files = []
    end
    PLATSPEC
        if [ "${stdenv.hostPlatform.parsed.kernel.name}" = "darwin" ]; then
          cat > $dest/specifications/libddwaf-1.24.1.0.3-universal-darwin.gemspec <<'UNISPEC'
    Gem::Specification.new do |s|
      s.name = "libddwaf"
      s.version = "1.24.1.0.3"
      s.platform = "universal-darwin"
      s.summary = "libddwaf"
      s.require_paths = ["lib"]
      s.files = []
    end
    UNISPEC
        fi
  '';
}
