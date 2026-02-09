#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth-oauth 1.2.1
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
  pname = "omniauth-oauth";
  version = "1.2.1";
  src = builtins.path {
    path = ./source;
    name = "omniauth-oauth-1.2.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/omniauth-oauth-1.2.1
        cp -r . $dest/gems/omniauth-oauth-1.2.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/omniauth-oauth-1.2.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "omniauth-oauth"
      s.version = "1.2.1"
      s.summary = "omniauth-oauth"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
