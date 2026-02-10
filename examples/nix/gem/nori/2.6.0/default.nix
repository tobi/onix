#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# nori 2.6.0
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
  pname = "nori";
  version = "2.6.0";
  src = builtins.path {
    path = ./source;
    name = "nori-2.6.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/nori-2.6.0
        cp -r . $dest/gems/nori-2.6.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/nori-2.6.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "nori"
      s.version = "2.6.0"
      s.summary = "nori"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
