#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-apis-core 1.0.1
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
  pname = "google-apis-core";
  version = "1.0.1";
  src = builtins.path {
    path = ./source;
    name = "google-apis-core-1.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/google-apis-core-1.0.1
        cp -r . $dest/gems/google-apis-core-1.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/google-apis-core-1.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "google-apis-core"
      s.version = "1.0.1"
      s.summary = "google-apis-core"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
