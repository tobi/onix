#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# os 1.1.4
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "os";
  version = "1.1.4";
  src = builtins.path { path = ./source; name = "os-1.1.4-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/os-1.1.4
    cp -r . $dest/gems/os-1.1.4/
    mkdir -p $dest/specifications
    cat > $dest/specifications/os-1.1.4.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "os"
  s.version = "1.1.4"
  s.summary = "os"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
