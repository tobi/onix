#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-swf 1.83.0
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
  pname = "aws-sdk-swf";
  version = "1.83.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sdk-swf-1.83.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-sdk-swf-1.83.0
        cp -r . $dest/gems/aws-sdk-swf-1.83.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sdk-swf-1.83.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sdk-swf"
      s.version = "1.83.0"
      s.summary = "aws-sdk-swf"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
