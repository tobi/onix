#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-apis-androidpublisher_v3 0.95.0
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
  pname = "google-apis-androidpublisher_v3";
  version = "0.95.0";
  src = builtins.path {
    path = ./source;
    name = "google-apis-androidpublisher_v3-0.95.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/google-apis-androidpublisher_v3-0.95.0
        cp -r . $dest/gems/google-apis-androidpublisher_v3-0.95.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/google-apis-androidpublisher_v3-0.95.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "google-apis-androidpublisher_v3"
      s.version = "0.95.0"
      s.summary = "google-apis-androidpublisher_v3"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
