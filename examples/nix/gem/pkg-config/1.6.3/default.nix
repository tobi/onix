#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pkg-config 1.6.3
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
  pname = "pkg-config";
  version = "1.6.3";
  src = builtins.path {
    path = ./source;
    name = "pkg-config-1.6.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/pkg-config-1.6.3
        cp -r . $dest/gems/pkg-config-1.6.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/pkg-config-1.6.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "pkg-config"
      s.version = "1.6.3"
      s.summary = "pkg-config"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
