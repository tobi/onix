#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# solid_cable 3.0.5
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
  pname = "solid_cable";
  version = "3.0.5";
  src = builtins.path {
    path = ./source;
    name = "solid_cable-3.0.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/solid_cable-3.0.5
        cp -r . $dest/gems/solid_cable-3.0.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/solid_cable-3.0.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "solid_cable"
      s.version = "3.0.5"
      s.summary = "solid_cable"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
