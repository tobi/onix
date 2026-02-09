#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-xray 1.96.0
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
  pname = "aws-sdk-xray";
  version = "1.96.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sdk-xray-1.96.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-sdk-xray-1.96.0
        cp -r . $dest/gems/aws-sdk-xray-1.96.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sdk-xray-1.96.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sdk-xray"
      s.version = "1.96.0"
      s.summary = "aws-sdk-xray"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
