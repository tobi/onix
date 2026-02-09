#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# listen 3.8.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "listen";
  version = "3.8.0";
  src = builtins.path { path = ./source; name = "listen-3.8.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/listen-3.8.0
    cp -r . $dest/gems/listen-3.8.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/listen-3.8.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "listen"
  s.version = "3.8.0"
  s.summary = "listen"
  s.require_paths = ["lib"]
  s.bindir = "bin"
  s.executables = ["listen"]
  s.files = []
end
EOF
    mkdir -p $dest/bin
    cat > $dest/bin/listen <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("listen", "listen", "3.8.0")
BINSTUB
    chmod +x $dest/bin/listen
  '';
}
