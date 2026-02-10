#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-cloud-env 2.3.1
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
  pname = "google-cloud-env";
  version = "2.3.1";
  src = builtins.path {
    path = ./source;
    name = "google-cloud-env-2.3.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/google-cloud-env-2.3.1
        cp -r . $dest/gems/google-cloud-env-2.3.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/google-cloud-env-2.3.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "google-cloud-env"
      s.version = "2.3.1"
      s.summary = "google-cloud-env"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
