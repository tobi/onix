#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth-saml 2.2.4
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "omniauth-saml";
  version = "2.2.4";
  src = builtins.path {
    path = ./source;
    name = "omniauth-saml-2.2.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/omniauth-saml-2.2.4
        cp -r . $dest/gems/omniauth-saml-2.2.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/omniauth-saml-2.2.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "omniauth-saml"
      s.version = "2.2.4"
      s.summary = "omniauth-saml"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
