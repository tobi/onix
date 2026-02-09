#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth_openid_connect 0.8.0
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
  pname = "omniauth_openid_connect";
  version = "0.8.0";
  src = builtins.path {
    path = ./source;
    name = "omniauth_openid_connect-0.8.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/omniauth_openid_connect-0.8.0
        cp -r . $dest/gems/omniauth_openid_connect-0.8.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/omniauth_openid_connect-0.8.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "omniauth_openid_connect"
      s.version = "0.8.0"
      s.summary = "omniauth_openid_connect"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
