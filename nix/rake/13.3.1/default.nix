#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rake 13.3.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "rake";
  version = "13.3.1";
  src = builtins.path { path = ./source; name = "rake-13.3.1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/rake-13.3.1
    cp -r . $dest/gems/rake-13.3.1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/rake-13.3.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "rake"
  s.version = "13.3.1"
  s.summary = "rake"
  s.require_paths = ["lib"]
  s.bindir = "exe"
  s.executables = ["rake"]
  s.files = []
end
EOF
    mkdir -p $dest/bin
    cat > $dest/bin/rake <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("rake", "rake", "13.3.1")
BINSTUB
    chmod +x $dest/bin/rake
  '';
}
