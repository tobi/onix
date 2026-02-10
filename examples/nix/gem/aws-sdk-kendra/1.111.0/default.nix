#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-kendra 1.111.0
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
  pname = "aws-sdk-kendra";
  version = "1.111.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sdk-kendra-1.111.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-sdk-kendra-1.111.0
        cp -r . $dest/gems/aws-sdk-kendra-1.111.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sdk-kendra-1.111.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sdk-kendra"
      s.version = "1.111.0"
      s.summary = "aws-sdk-kendra"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
