#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jwt 3.1.2
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
  pname = "jwt";
  version = "3.1.2";
  src = builtins.path {
    path = ./source;
    name = "jwt-3.1.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/jwt-3.1.2
        cp -r . $dest/gems/jwt-3.1.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/jwt-3.1.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "jwt"
      s.version = "3.1.2"
      s.summary = "jwt"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
