#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-codegurureviewer 1.75.0
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
  pname = "aws-sdk-codegurureviewer";
  version = "1.75.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sdk-codegurureviewer-1.75.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-sdk-codegurureviewer-1.75.0
        cp -r . $dest/gems/aws-sdk-codegurureviewer-1.75.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sdk-codegurureviewer-1.75.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sdk-codegurureviewer"
      s.version = "1.75.0"
      s.summary = "aws-sdk-codegurureviewer"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
