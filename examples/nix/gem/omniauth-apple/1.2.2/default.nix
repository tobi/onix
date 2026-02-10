#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth-apple 1.2.2
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
  pname = "omniauth-apple";
  version = "1.2.2";
  src = builtins.path {
    path = ./source;
    name = "omniauth-apple-1.2.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/omniauth-apple-1.2.2
        cp -r . $dest/gems/omniauth-apple-1.2.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/omniauth-apple-1.2.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "omniauth-apple"
      s.version = "1.2.2"
      s.summary = "omniauth-apple"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
