#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mini_suffix 0.3.3
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
  pname = "mini_suffix";
  version = "0.3.3";
  src = builtins.path {
    path = ./source;
    name = "mini_suffix-0.3.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/mini_suffix-0.3.3
        cp -r . $dest/gems/mini_suffix-0.3.3/
        local extdir=$dest/extensions/${arch}/${rubyVersion}/mini_suffix-0.3.3
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
        ln -s mini_suffix-0.3.3 $dest/gems/mini_suffix-0.3.3-$gp
        ln -s mini_suffix-0.3.3 $dest/extensions/${arch}/${rubyVersion}/mini_suffix-0.3.3-$gp
        if [ "${stdenv.hostPlatform.parsed.kernel.name}" = "darwin" ]; then
          ln -sf mini_suffix-0.3.3 $dest/gems/mini_suffix-0.3.3-universal-darwin
          ln -sf mini_suffix-0.3.3 $dest/extensions/${arch}/${rubyVersion}/mini_suffix-0.3.3-universal-darwin
        fi
        mkdir -p $dest/specifications
        cat > $dest/specifications/mini_suffix-0.3.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mini_suffix"
      s.version = "0.3.3"
      s.summary = "mini_suffix"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
        cat > $dest/specifications/mini_suffix-0.3.3-$gp.gemspec <<PLATSPEC
    Gem::Specification.new do |s|
      s.name = "mini_suffix"
      s.version = "0.3.3"
      s.platform = "$gp"
      s.summary = "mini_suffix"
      s.require_paths = ["lib"]
      s.files = []
    end
    PLATSPEC
        if [ "${stdenv.hostPlatform.parsed.kernel.name}" = "darwin" ]; then
          cat > $dest/specifications/mini_suffix-0.3.3-universal-darwin.gemspec <<'UNISPEC'
    Gem::Specification.new do |s|
      s.name = "mini_suffix"
      s.version = "0.3.3"
      s.platform = "universal-darwin"
      s.summary = "mini_suffix"
      s.require_paths = ["lib"]
      s.files = []
    end
    UNISPEC
        fi
  '';
}
