#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-kinesisanalyticsv2 1.87.0
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
  pname = "aws-sdk-kinesisanalyticsv2";
  version = "1.87.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sdk-kinesisanalyticsv2-1.87.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-sdk-kinesisanalyticsv2-1.87.0
        cp -r . $dest/gems/aws-sdk-kinesisanalyticsv2-1.87.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sdk-kinesisanalyticsv2-1.87.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sdk-kinesisanalyticsv2"
      s.version = "1.87.0"
      s.summary = "aws-sdk-kinesisanalyticsv2"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
