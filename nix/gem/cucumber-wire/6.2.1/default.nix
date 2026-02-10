#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cucumber-wire 6.2.1
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
  pname = "cucumber-wire";
  version = "6.2.1";
  src = builtins.path {
    path = ./source;
    name = "cucumber-wire-6.2.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/cucumber-wire-6.2.1
        cp -r . $dest/gems/cucumber-wire-6.2.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/cucumber-wire-6.2.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "cucumber-wire"
      s.version = "6.2.1"
      s.summary = "cucumber-wire"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
