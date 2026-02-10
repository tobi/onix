#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-sdk-workspaces 1.153.0
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
  pname = "aws-sdk-workspaces";
  version = "1.153.0";
  src = builtins.path {
    path = ./source;
    name = "aws-sdk-workspaces-1.153.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-sdk-workspaces-1.153.0
        cp -r . $dest/gems/aws-sdk-workspaces-1.153.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-sdk-workspaces-1.153.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-sdk-workspaces"
      s.version = "1.153.0"
      s.summary = "aws-sdk-workspaces"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
