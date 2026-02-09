#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-connect 1.238.0
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
  pname = "aws-sdk-connect";
  version = "1.238.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sdk-connect-1.238.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-sdk-connect-1.238.0
        cp -r . $dest/gems/aws-sdk-connect-1.238.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sdk-connect-1.238.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sdk-connect"
      s.version = "1.238.0"
      s.summary = "aws-sdk-connect"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
