#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cose 1.3.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "cose";
  version = "1.3.1";
  src = builtins.path { path = ./source; name = "cose-1.3.1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/cose-1.3.1
    cp -r . $dest/gems/cose-1.3.1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/cose-1.3.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "cose"
  s.version = "1.3.1"
  s.summary = "cose"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
