#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cocoon 1.2.15
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
  pname = "cocoon";
  version = "1.2.15";
  src = builtins.path {
    path = ./source;
    name = "cocoon-1.2.15-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/cocoon-1.2.15
        cp -r . $dest/gems/cocoon-1.2.15/
        mkdir -p $dest/specifications
        cat > $dest/specifications/cocoon-1.2.15.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "cocoon"
      s.version = "1.2.15"
      s.summary = "cocoon"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
