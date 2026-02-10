#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-athena 1.117.0
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
  pname = "aws-sdk-athena";
  version = "1.117.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sdk-athena-1.117.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-sdk-athena-1.117.0
        cp -r . $dest/gems/aws-sdk-athena-1.117.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sdk-athena-1.117.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sdk-athena"
      s.version = "1.117.0"
      s.summary = "aws-sdk-athena"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
