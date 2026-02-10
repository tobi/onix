#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gems 1.2.0
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
  pname = "gems";
  version = "1.2.0";
  src = builtins.path {
    path = ./source;
    name = "gems-1.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/gems-1.2.0
        cp -r . $dest/gems/gems-1.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/gems-1.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "gems"
      s.version = "1.2.0"
      s.summary = "gems"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
