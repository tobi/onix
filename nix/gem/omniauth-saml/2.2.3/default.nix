#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth-saml 2.2.3
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
  pname = "omniauth-saml";
  version = "2.2.3";
  src = builtins.path {
    path = ./source;
    name = "omniauth-saml-2.2.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/omniauth-saml-2.2.3
        cp -r . $dest/gems/omniauth-saml-2.2.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/omniauth-saml-2.2.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "omniauth-saml"
      s.version = "2.2.3"
      s.summary = "omniauth-saml"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
