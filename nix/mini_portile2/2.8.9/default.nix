#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mini_portile2 2.8.9
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "mini_portile2";
  version = "2.8.9";
  src = builtins.path { path = ./source; name = "mini_portile2-2.8.9-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/mini_portile2-2.8.9
    cp -r . $dest/gems/mini_portile2-2.8.9/
    mkdir -p $dest/specifications
    cat > $dest/specifications/mini_portile2-2.8.9.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "mini_portile2"
  s.version = "2.8.9"
  s.summary = "mini_portile2"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
