#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# brakeman 5.4.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "brakeman";
  version = "5.4.1";
  src = builtins.path { path = ./source; name = "brakeman-5.4.1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/brakeman-5.4.1
    cp -r . $dest/gems/brakeman-5.4.1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/brakeman-5.4.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "brakeman"
  s.version = "5.4.1"
  s.summary = "brakeman"
  s.require_paths = ["lib"]
  s.bindir = "bin"
  s.executables = ["brakeman"]
  s.files = []
end
EOF
    mkdir -p $dest/bin
    cat > $dest/bin/brakeman <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("brakeman", "brakeman", "5.4.1")
BINSTUB
    chmod +x $dest/bin/brakeman
  '';
}
