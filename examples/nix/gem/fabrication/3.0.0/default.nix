#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fabrication 3.0.0
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
  pname = "fabrication";
  version = "3.0.0";
  src = builtins.path {
    path = ./source;
    name = "fabrication-3.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fabrication-3.0.0
        cp -r . $dest/gems/fabrication-3.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fabrication-3.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fabrication"
      s.version = "3.0.0"
      s.summary = "fabrication"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
