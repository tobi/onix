#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# artifactory 3.0.13
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
  pname = "artifactory";
  version = "3.0.13";
  src = builtins.path {
    path = ./source;
    name = "artifactory-3.0.13-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/artifactory-3.0.13
        cp -r . $dest/gems/artifactory-3.0.13/
        mkdir -p $dest/specifications
        cat > $dest/specifications/artifactory-3.0.13.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "artifactory"
      s.version = "3.0.13"
      s.summary = "artifactory"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
