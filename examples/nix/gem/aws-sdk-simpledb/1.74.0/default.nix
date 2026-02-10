#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-simpledb 1.74.0
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
  pname = "aws-sdk-simpledb";
  version = "1.74.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sdk-simpledb-1.74.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-sdk-simpledb-1.74.0
        cp -r . $dest/gems/aws-sdk-simpledb-1.74.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sdk-simpledb-1.74.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sdk-simpledb"
      s.version = "1.74.0"
      s.summary = "aws-sdk-simpledb"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
