#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# uber 0.1.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "uber";
  version = "0.1.0";
  src = builtins.path { path = ./source; name = "uber-0.1.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/uber-0.1.0
    cp -r . $dest/gems/uber-0.1.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/uber-0.1.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "uber"
  s.version = "0.1.0"
  s.summary = "uber"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
