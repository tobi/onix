#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth-google-oauth2 1.1.2
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
  pname = "omniauth-google-oauth2";
  version = "1.1.2";
  src = builtins.path {
    path = ./source;
    name = "omniauth-google-oauth2-1.1.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/omniauth-google-oauth2-1.1.2
        cp -r . $dest/gems/omniauth-google-oauth2-1.1.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/omniauth-google-oauth2-1.1.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "omniauth-google-oauth2"
      s.version = "1.1.2"
      s.summary = "omniauth-google-oauth2"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
