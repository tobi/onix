#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# omniauth 2.1.2
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
  pname = "omniauth";
  version = "2.1.2";
  src = builtins.path {
    path = ./source;
    name = "omniauth-2.1.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/omniauth-2.1.2
        cp -r . $dest/gems/omniauth-2.1.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/omniauth-2.1.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "omniauth"
      s.version = "2.1.2"
      s.summary = "omniauth"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
