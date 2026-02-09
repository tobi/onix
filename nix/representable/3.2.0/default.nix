#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# representable 3.2.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "representable";
  version = "3.2.0";
  src = builtins.path { path = ./source; name = "representable-3.2.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/representable-3.2.0
    cp -r . $dest/gems/representable-3.2.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/representable-3.2.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "representable"
  s.version = "3.2.0"
  s.summary = "representable"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
