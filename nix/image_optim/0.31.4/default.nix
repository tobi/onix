#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# image_optim 0.31.4
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "image_optim";
  version = "0.31.4";
  src = builtins.path { path = ./source; name = "image_optim-0.31.4-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/image_optim-0.31.4
    cp -r . $dest/gems/image_optim-0.31.4/
    mkdir -p $dest/specifications
    cat > $dest/specifications/image_optim-0.31.4.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "image_optim"
  s.version = "0.31.4"
  s.summary = "image_optim"
  s.require_paths = ["lib"]
  s.bindir = "bin"
  s.executables = ["image_optim"]
  s.files = []
end
EOF
    mkdir -p $dest/bin
    cat > $dest/bin/image_optim <<'BINSTUB'
#!/usr/bin/env ruby
require "rubygems"
load Gem.bin_path("image_optim", "image_optim", "0.31.4")
BINSTUB
    chmod +x $dest/bin/image_optim
  '';
}
