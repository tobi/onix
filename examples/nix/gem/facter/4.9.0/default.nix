#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# facter 4.9.0
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
  pname = "facter";
  version = "4.9.0";
  src = builtins.path {
    path = ./source;
    name = "facter-4.9.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/facter-4.9.0
        cp -r . $dest/gems/facter-4.9.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/facter-4.9.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "facter"
      s.version = "4.9.0"
      s.summary = "facter"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["facter"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/facter <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("facter", "facter", "4.9.0")
    BINSTUB
        chmod +x $dest/bin/facter
  '';
}
