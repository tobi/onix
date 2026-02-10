#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# chartkick 4.2.1
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
  pname = "chartkick";
  version = "4.2.1";
  src = builtins.path {
    path = ./source;
    name = "chartkick-4.2.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/chartkick-4.2.1
        cp -r . $dest/gems/chartkick-4.2.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/chartkick-4.2.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "chartkick"
      s.version = "4.2.1"
      s.summary = "chartkick"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
