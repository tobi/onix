#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby2ruby 2.5.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "ruby2ruby";
  version = "2.5.0";
  src = builtins.path { path = ./source; name = "ruby2ruby-2.5.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/ruby2ruby-2.5.0
    cp -r . $dest/gems/ruby2ruby-2.5.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/ruby2ruby-2.5.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "ruby2ruby"
  s.version = "2.5.0"
  s.summary = "ruby2ruby"
  s.require_paths = ["lib"]
  s.bindir = "bin"
  s.executables = ["r2r_show"]
  s.files = []
end
EOF
    mkdir -p $dest/bin
    cat > $dest/bin/r2r_show <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("ruby2ruby", "r2r_show", "2.5.0")
BINSTUB
    chmod +x $dest/bin/r2r_show
  '';
}
