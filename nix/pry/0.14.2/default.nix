#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pry 0.14.2
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "pry";
  version = "0.14.2";
  src = builtins.path { path = ./source; name = "pry-0.14.2-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/pry-0.14.2
    cp -r . $dest/gems/pry-0.14.2/
    mkdir -p $dest/specifications
    cat > $dest/specifications/pry-0.14.2.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "pry"
  s.version = "0.14.2"
  s.summary = "pry"
  s.require_paths = ["lib"]
  s.bindir = "bin"
  s.executables = ["pry"]
  s.files = []
end
EOF
    mkdir -p $dest/bin
    cat > $dest/bin/pry <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("pry", "pry", "0.14.2")
BINSTUB
    chmod +x $dest/bin/pry
  '';
}
