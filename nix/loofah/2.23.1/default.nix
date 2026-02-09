#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# loofah 2.23.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "loofah";
  version = "2.23.1";
  src = builtins.path { path = ./source; name = "loofah-2.23.1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/loofah-2.23.1
    cp -r . $dest/gems/loofah-2.23.1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/loofah-2.23.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "loofah"
  s.version = "2.23.1"
  s.summary = "loofah"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
