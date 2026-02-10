#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-augmentedairuntime 1.65.0
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
  pname = "aws-sdk-augmentedairuntime";
  version = "1.65.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sdk-augmentedairuntime-1.65.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-sdk-augmentedairuntime-1.65.0
        cp -r . $dest/gems/aws-sdk-augmentedairuntime-1.65.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sdk-augmentedairuntime-1.65.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sdk-augmentedairuntime"
      s.version = "1.65.0"
      s.summary = "aws-sdk-augmentedairuntime"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
