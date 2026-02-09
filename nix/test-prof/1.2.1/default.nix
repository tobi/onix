#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# test-prof 1.2.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "test-prof";
  version = "1.2.1";
  src = builtins.path { path = ./source; name = "test-prof-1.2.1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/test-prof-1.2.1
    cp -r . $dest/gems/test-prof-1.2.1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/test-prof-1.2.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "test-prof"
  s.version = "1.2.1"
  s.summary = "test-prof"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
