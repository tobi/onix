#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-apis-core 1.0.2
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
  version = "1.0.2";
  src = builtins.path {
    path = ./source;
    name = "google-apis-core-1.0.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/google-apis-core-1.0.2
        cp -r . $dest/gems/google-apis-core-1.0.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/google-apis-core-1.0.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "google-apis-core"
      s.version = "1.0.2"
      s.summary = "google-apis-core"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
