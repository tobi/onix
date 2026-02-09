#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# coderay 1.1.3
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "coderay";
  version = "1.1.3";
  src = builtins.path { path = ./source; name = "coderay-1.1.3-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/coderay-1.1.3
    cp -r . $dest/gems/coderay-1.1.3/
    mkdir -p $dest/specifications
    cat > $dest/specifications/coderay-1.1.3.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "coderay"
  s.version = "1.1.3"
  s.summary = "coderay"
  s.require_paths = ["lib"]
  s.bindir = "bin"
  s.executables = ["coderay"]
  s.files = []
end
EOF
    mkdir -p $dest/bin
    cat > $dest/bin/coderay <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("coderay", "coderay", "1.1.3")
BINSTUB
    chmod +x $dest/bin/coderay
  '';
}
