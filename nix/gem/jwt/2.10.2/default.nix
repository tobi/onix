#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jwt 2.10.2
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
  pname = "jwt";
  version = "2.10.2";
  src = builtins.path {
    path = ./source;
    name = "jwt-2.10.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/jwt-2.10.2
        cp -r . $dest/gems/jwt-2.10.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/jwt-2.10.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "jwt"
      s.version = "2.10.2"
      s.summary = "jwt"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
