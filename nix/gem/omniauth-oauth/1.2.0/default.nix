#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth-oauth 1.2.0
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
  pname = "omniauth-oauth";
  version = "1.2.0";
  src = builtins.path {
    path = ./source;
    name = "omniauth-oauth-1.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/omniauth-oauth-1.2.0
        cp -r . $dest/gems/omniauth-oauth-1.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/omniauth-oauth-1.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "omniauth-oauth"
      s.version = "1.2.0"
      s.summary = "omniauth-oauth"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
