#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tilt 2.6.1
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
  pname = "tilt";
  version = "2.6.1";
  src = builtins.path {
    path = ./source;
    name = "tilt-2.6.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/tilt-2.6.1
        cp -r . $dest/gems/tilt-2.6.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/tilt-2.6.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "tilt"
      s.version = "2.6.1"
      s.summary = "tilt"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["tilt"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/tilt <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("tilt", "tilt", "2.6.1")
    BINSTUB
        chmod +x $dest/bin/tilt
  '';
}
