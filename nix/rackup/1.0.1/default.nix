#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rackup 1.0.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "rackup";
  version = "1.0.1";
  src = builtins.path { path = ./source; name = "rackup-1.0.1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/rackup-1.0.1
    cp -r . $dest/gems/rackup-1.0.1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/rackup-1.0.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "rackup"
  s.version = "1.0.1"
  s.summary = "rackup"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
