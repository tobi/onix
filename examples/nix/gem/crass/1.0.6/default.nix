#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# crass 1.0.6
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
  pname = "crass";
  version = "1.0.6";
  src = builtins.path {
    path = ./source;
    name = "crass-1.0.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/crass-1.0.6
        cp -r . $dest/gems/crass-1.0.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/crass-1.0.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "crass"
      s.version = "1.0.6"
      s.summary = "crass"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
