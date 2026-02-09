#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# httpclient 2.8.3
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "httpclient";
  version = "2.8.3";
  src = builtins.path { path = ./source; name = "httpclient-2.8.3-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/httpclient-2.8.3
    cp -r . $dest/gems/httpclient-2.8.3/
    mkdir -p $dest/specifications
    cat > $dest/specifications/httpclient-2.8.3.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "httpclient"
  s.version = "2.8.3"
  s.summary = "httpclient"
  s.require_paths = ["lib"]
  s.bindir = "bin"
  s.executables = ["httpclient"]
  s.files = []
end
EOF
    mkdir -p $dest/bin
    cat > $dest/bin/httpclient <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("httpclient", "httpclient", "2.8.3")
BINSTUB
    chmod +x $dest/bin/httpclient
  '';
}
