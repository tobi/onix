#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# json_schemer 0.2.24
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "json_schemer";
  version = "0.2.24";
  src = builtins.path { path = ./source; name = "json_schemer-0.2.24-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/json_schemer-0.2.24
    cp -r . $dest/gems/json_schemer-0.2.24/
    mkdir -p $dest/specifications
    cat > $dest/specifications/json_schemer-0.2.24.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "json_schemer"
  s.version = "0.2.24"
  s.summary = "json_schemer"
  s.require_paths = ["lib"]
  s.bindir = "exe"
  s.executables = ["json_schemer"]
  s.files = []
end
EOF
    mkdir -p $dest/bin
    cat > $dest/bin/json_schemer <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("json_schemer", "json_schemer", "0.2.24")
BINSTUB
    chmod +x $dest/bin/json_schemer
  '';
}
