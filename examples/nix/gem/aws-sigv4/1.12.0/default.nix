#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sigv4 1.12.0
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
  pname = "aws-sigv4";
  version = "1.12.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sigv4-1.12.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-sigv4-1.12.0
        cp -r . $dest/gems/aws-sigv4-1.12.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sigv4-1.12.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sigv4"
      s.version = "1.12.0"
      s.summary = "aws-sigv4"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
