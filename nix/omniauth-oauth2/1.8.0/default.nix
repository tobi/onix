#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth-oauth2 1.8.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "omniauth-oauth2";
  version = "1.8.0";
  src = builtins.path { path = ./source; name = "omniauth-oauth2-1.8.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/omniauth-oauth2-1.8.0
    cp -r . $dest/gems/omniauth-oauth2-1.8.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/omniauth-oauth2-1.8.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "omniauth-oauth2"
  s.version = "1.8.0"
  s.summary = "omniauth-oauth2"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
