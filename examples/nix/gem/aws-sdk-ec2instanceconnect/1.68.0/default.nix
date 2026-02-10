#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-ec2instanceconnect 1.68.0
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
  pname = "aws-sdk-ec2instanceconnect";
  version = "1.68.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sdk-ec2instanceconnect-1.68.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-sdk-ec2instanceconnect-1.68.0
        cp -r . $dest/gems/aws-sdk-ec2instanceconnect-1.68.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sdk-ec2instanceconnect-1.68.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sdk-ec2instanceconnect"
      s.version = "1.68.0"
      s.summary = "aws-sdk-ec2instanceconnect"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
