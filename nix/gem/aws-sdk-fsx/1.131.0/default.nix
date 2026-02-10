#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-fsx 1.131.0
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
  pname = "aws-sdk-fsx";
  version = "1.131.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sdk-fsx-1.131.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-sdk-fsx-1.131.0
        cp -r . $dest/gems/aws-sdk-fsx-1.131.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sdk-fsx-1.131.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sdk-fsx"
      s.version = "1.131.0"
      s.summary = "aws-sdk-fsx"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
