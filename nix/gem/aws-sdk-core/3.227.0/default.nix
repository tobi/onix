#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-core 3.227.0
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "aws-sdk-core";
  version = "3.227.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sdk-core-3.227.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/aws-sdk-core-3.227.0
        cp -r . $dest/gems/aws-sdk-core-3.227.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sdk-core-3.227.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sdk-core"
      s.version = "3.227.0"
      s.summary = "aws-sdk-core"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
