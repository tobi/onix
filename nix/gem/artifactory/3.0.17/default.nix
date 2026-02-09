#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# artifactory 3.0.17
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
  version = "3.0.17";
  src = builtins.path {
    path = ./source;
    name = "artifactory-3.0.17-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/artifactory-3.0.17
        cp -r . $dest/gems/artifactory-3.0.17/
        mkdir -p $dest/specifications
        cat > $dest/specifications/artifactory-3.0.17.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "artifactory"
      s.version = "3.0.17"
      s.summary = "artifactory"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
