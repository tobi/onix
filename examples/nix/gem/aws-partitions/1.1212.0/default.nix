#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-partitions 1.1212.0
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
  pname = "aws-partitions";
  version = "1.1212.0";
  src = builtins.path {
    path = ./source;
    name = "aws-partitions-1.1212.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-partitions-1.1212.0
        cp -r . $dest/gems/aws-partitions-1.1212.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-partitions-1.1212.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-partitions"
      s.version = "1.1212.0"
      s.summary = "aws-partitions"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
