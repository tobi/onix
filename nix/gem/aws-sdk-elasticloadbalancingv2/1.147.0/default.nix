#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-elasticloadbalancingv2 1.147.0
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
  pname = "aws-sdk-elasticloadbalancingv2";
  version = "1.147.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sdk-elasticloadbalancingv2-1.147.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-sdk-elasticloadbalancingv2-1.147.0
        cp -r . $dest/gems/aws-sdk-elasticloadbalancingv2-1.147.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sdk-elasticloadbalancingv2-1.147.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sdk-elasticloadbalancingv2"
      s.version = "1.147.0"
      s.summary = "aws-sdk-elasticloadbalancingv2"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
