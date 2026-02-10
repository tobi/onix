#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-appconfig 1.77.0
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
  pname = "aws-sdk-appconfig";
  version = "1.77.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sdk-appconfig-1.77.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-sdk-appconfig-1.77.0
        cp -r . $dest/gems/aws-sdk-appconfig-1.77.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sdk-appconfig-1.77.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sdk-appconfig"
      s.version = "1.77.0"
      s.summary = "aws-sdk-appconfig"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
