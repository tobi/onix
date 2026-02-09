#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth-facebook 9.0.0
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
  pname = "omniauth-facebook";
  version = "9.0.0";
  src = builtins.path {
    path = ./source;
    name = "omniauth-facebook-9.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/omniauth-facebook-9.0.0
        cp -r . $dest/gems/omniauth-facebook-9.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/omniauth-facebook-9.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "omniauth-facebook"
      s.version = "9.0.0"
      s.summary = "omniauth-facebook"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
