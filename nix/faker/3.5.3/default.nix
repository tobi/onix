#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faker 3.5.3
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "faker";
  version = "3.5.3";
  src = builtins.path { path = ./source; name = "faker-3.5.3-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/faker-3.5.3
    cp -r . $dest/gems/faker-3.5.3/
    mkdir -p $dest/specifications
    cat > $dest/specifications/faker-3.5.3.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "faker"
  s.version = "3.5.3"
  s.summary = "faker"
  s.require_paths = ["lib"]
  s.bindir = "bin"
  s.executables = ["faker"]
  s.files = []
end
EOF
    mkdir -p $dest/bin
    cat > $dest/bin/faker <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("faker", "faker", "3.5.3")
BINSTUB
    chmod +x $dest/bin/faker
  '';
}
