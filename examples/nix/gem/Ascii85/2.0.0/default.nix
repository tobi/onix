#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# Ascii85 2.0.0
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
  pname = "Ascii85";
  version = "2.0.0";
  src = builtins.path {
    path = ./source;
    name = "Ascii85-2.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/Ascii85-2.0.0
        cp -r . $dest/gems/Ascii85-2.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/Ascii85-2.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "Ascii85"
      s.version = "2.0.0"
      s.summary = "Ascii85"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["ascii85"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/ascii85 <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("Ascii85", "ascii85", "2.0.0")
    BINSTUB
        chmod +x $dest/bin/ascii85
  '';
}
