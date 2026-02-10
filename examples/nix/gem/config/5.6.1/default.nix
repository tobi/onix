#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# config 5.6.1
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
  pname = "config";
  version = "5.6.1";
  src = builtins.path {
    path = ./source;
    name = "config-5.6.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/config-5.6.1
        cp -r . $dest/gems/config-5.6.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/config-5.6.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "config"
      s.version = "5.6.1"
      s.summary = "config"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
