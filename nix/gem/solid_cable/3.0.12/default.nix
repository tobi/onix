#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# solid_cable 3.0.12
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
  pname = "solid_cable";
  version = "3.0.12";
  src = builtins.path {
    path = ./source;
    name = "solid_cable-3.0.12-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/solid_cable-3.0.12
        cp -r . $dest/gems/solid_cable-3.0.12/
        mkdir -p $dest/specifications
        cat > $dest/specifications/solid_cable-3.0.12.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "solid_cable"
      s.version = "3.0.12"
      s.summary = "solid_cable"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
