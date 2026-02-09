#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# thruster 0.1.17
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "thruster";
  version = "0.1.17";
  src = builtins.path { path = ./source; name = "thruster-0.1.17-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/thruster-0.1.17
    cp -r . $dest/gems/thruster-0.1.17/
    mkdir -p $dest/specifications
    cat > $dest/specifications/thruster-0.1.17.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "thruster"
  s.version = "0.1.17"
  s.summary = "thruster"
  s.require_paths = ["lib"]
  s.bindir = "exe"
  s.executables = ["thrust"]
  s.files = []
end
EOF
    mkdir -p $dest/bin
    cat > $dest/bin/thrust <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("thruster", "thrust", "0.1.17")
BINSTUB
    chmod +x $dest/bin/thrust
  '';
}
