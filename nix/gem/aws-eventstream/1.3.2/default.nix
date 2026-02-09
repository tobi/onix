#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-eventstream 1.3.2
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
  pname = "aws-eventstream";
  version = "1.3.2";
  src = builtins.path {
    path = ./source;
    name = "aws-eventstream-1.3.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-eventstream-1.3.2
        cp -r . $dest/gems/aws-eventstream-1.3.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-eventstream-1.3.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-eventstream"
      s.version = "1.3.2"
      s.summary = "aws-eventstream"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
