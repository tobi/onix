#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-codestar 1.57.0
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
  pname = "aws-sdk-codestar";
  version = "1.57.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sdk-codestar-1.57.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-sdk-codestar-1.57.0
        cp -r . $dest/gems/aws-sdk-codestar-1.57.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sdk-codestar-1.57.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sdk-codestar"
      s.version = "1.57.0"
      s.summary = "aws-sdk-codestar"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
