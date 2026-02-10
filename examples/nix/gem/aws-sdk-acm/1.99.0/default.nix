#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-acm 1.99.0
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
  pname = "aws-sdk-acm";
  version = "1.99.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sdk-acm-1.99.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-sdk-acm-1.99.0
        cp -r . $dest/gems/aws-sdk-acm-1.99.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sdk-acm-1.99.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sdk-acm"
      s.version = "1.99.0"
      s.summary = "aws-sdk-acm"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
