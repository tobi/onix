#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# minitest 6.0.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "minitest";
  version = "6.0.1";
  src = builtins.path { path = ./source; name = "minitest-6.0.1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/minitest-6.0.1
    cp -r . $dest/gems/minitest-6.0.1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/minitest-6.0.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "minitest"
  s.version = "6.0.1"
  s.summary = "minitest"
  s.require_paths = ["lib"]
  s.bindir = "bin"
  s.executables = ["minitest"]
  s.files = []
end
EOF
    mkdir -p $dest/bin
    cat > $dest/bin/minitest <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("minitest", "minitest", "6.0.1")
BINSTUB
    chmod +x $dest/bin/minitest
  '';
}
