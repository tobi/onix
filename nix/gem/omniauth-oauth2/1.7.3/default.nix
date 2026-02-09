#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth-oauth2 1.7.3
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
  pname = "omniauth-oauth2";
  version = "1.7.3";
  src = builtins.path {
    path = ./source;
    name = "omniauth-oauth2-1.7.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/omniauth-oauth2-1.7.3
        cp -r . $dest/gems/omniauth-oauth2-1.7.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/omniauth-oauth2-1.7.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "omniauth-oauth2"
      s.version = "1.7.3"
      s.summary = "omniauth-oauth2"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
