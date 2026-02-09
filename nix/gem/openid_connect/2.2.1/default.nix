#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# openid_connect 2.2.1
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
  pname = "openid_connect";
  version = "2.2.1";
  src = builtins.path {
    path = ./source;
    name = "openid_connect-2.2.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/openid_connect-2.2.1
        cp -r . $dest/gems/openid_connect-2.2.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/openid_connect-2.2.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "openid_connect"
      s.version = "2.2.1"
      s.summary = "openid_connect"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
