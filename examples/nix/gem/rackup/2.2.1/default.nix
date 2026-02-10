#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rackup 2.2.1
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  bundle_path = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "rackup";
  version = "2.2.1";
  src = builtins.path {
    path = ./source;
    name = "rackup-2.2.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rackup-2.2.1
        cp -r . $dest/gems/rackup-2.2.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rackup-2.2.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rackup"
      s.version = "2.2.1"
      s.summary = "rackup"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["rackup"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/rackup <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rackup", "rackup", "2.2.1")
    BINSTUB
        chmod +x $dest/bin/rackup
  '';
}
