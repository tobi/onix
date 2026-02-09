#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-ldap 0.20.0
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
  pname = "net-ldap";
  version = "0.20.0";
  src = builtins.path {
    path = ./source;
    name = "net-ldap-0.20.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/net-ldap-0.20.0
        cp -r . $dest/gems/net-ldap-0.20.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/net-ldap-0.20.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "net-ldap"
      s.version = "0.20.0"
      s.summary = "net-ldap"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
