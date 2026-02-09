#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# propshaft 1.3.1
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
  pname = "propshaft";
  version = "1.3.1";
  src = builtins.path {
    path = ./source;
    name = "propshaft-1.3.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/propshaft-1.3.1
        cp -r . $dest/gems/propshaft-1.3.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/propshaft-1.3.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "propshaft"
      s.version = "1.3.1"
      s.summary = "propshaft"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
