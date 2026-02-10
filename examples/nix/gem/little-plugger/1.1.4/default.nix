#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# little-plugger 1.1.4
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
  pname = "little-plugger";
  version = "1.1.4";
  src = builtins.path {
    path = ./source;
    name = "little-plugger-1.1.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/little-plugger-1.1.4
        cp -r . $dest/gems/little-plugger-1.1.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/little-plugger-1.1.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "little-plugger"
      s.version = "1.1.4"
      s.summary = "little-plugger"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
