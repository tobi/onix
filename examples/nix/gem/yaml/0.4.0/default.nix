#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# yaml 0.4.0
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
  pname = "yaml";
  version = "0.4.0";
  src = builtins.path {
    path = ./source;
    name = "yaml-0.4.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/yaml-0.4.0
        cp -r . $dest/gems/yaml-0.4.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/yaml-0.4.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "yaml"
      s.version = "0.4.0"
      s.summary = "yaml"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
