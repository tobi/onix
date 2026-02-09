#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# exifr 1.4.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "exifr";
  version = "1.4.1";
  src = builtins.path { path = ./source; name = "exifr-1.4.1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/exifr-1.4.1
    cp -r . $dest/gems/exifr-1.4.1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/exifr-1.4.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "exifr"
  s.version = "1.4.1"
  s.summary = "exifr"
  s.require_paths = ["lib"]
  s.bindir = "bin"
  s.executables = ["exifr"]
  s.files = []
end
EOF
    mkdir -p $dest/bin
    cat > $dest/bin/exifr <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("exifr", "exifr", "1.4.1")
BINSTUB
    chmod +x $dest/bin/exifr
  '';
}
