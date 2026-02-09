#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# attr_extras 7.1.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "attr_extras";
  version = "7.1.0";
  src = builtins.path { path = ./source; name = "attr_extras-7.1.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/attr_extras-7.1.0
    cp -r . $dest/gems/attr_extras-7.1.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/attr_extras-7.1.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "attr_extras"
  s.version = "7.1.0"
  s.summary = "attr_extras"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
