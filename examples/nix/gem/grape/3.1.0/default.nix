#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# grape 3.1.0
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
  pname = "grape";
  version = "3.1.0";
  src = builtins.path {
    path = ./source;
    name = "grape-3.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/grape-3.1.0
        cp -r . $dest/gems/grape-3.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/grape-3.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "grape"
      s.version = "3.1.0"
      s.summary = "grape"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
