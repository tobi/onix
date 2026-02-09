#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# websocket 1.2.11
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "websocket";
  version = "1.2.11";
  src = builtins.path { path = ./source; name = "websocket-1.2.11-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/websocket-1.2.11
    cp -r . $dest/gems/websocket-1.2.11/
    mkdir -p $dest/specifications
    cat > $dest/specifications/websocket-1.2.11.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "websocket"
  s.version = "1.2.11"
  s.summary = "websocket"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
