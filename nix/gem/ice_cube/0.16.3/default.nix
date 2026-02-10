#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ice_cube 0.16.3
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
  pname = "ice_cube";
  version = "0.16.3";
  src = builtins.path {
    path = ./source;
    name = "ice_cube-0.16.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ice_cube-0.16.3
        cp -r . $dest/gems/ice_cube-0.16.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ice_cube-0.16.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ice_cube"
      s.version = "0.16.3"
      s.summary = "ice_cube"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
