#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-cloud-errors 1.4.0
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
  pname = "google-cloud-errors";
  version = "1.4.0";
  src = builtins.path {
    path = ./source;
    name = "google-cloud-errors-1.4.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/google-cloud-errors-1.4.0
        cp -r . $dest/gems/google-cloud-errors-1.4.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/google-cloud-errors-1.4.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "google-cloud-errors"
      s.version = "1.4.0"
      s.summary = "google-cloud-errors"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
