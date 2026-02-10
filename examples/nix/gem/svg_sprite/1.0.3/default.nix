#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# svg_sprite 1.0.3
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
  pname = "svg_sprite";
  version = "1.0.3";
  src = builtins.path {
    path = ./source;
    name = "svg_sprite-1.0.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/svg_sprite-1.0.3
        cp -r . $dest/gems/svg_sprite-1.0.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/svg_sprite-1.0.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "svg_sprite"
      s.version = "1.0.3"
      s.summary = "svg_sprite"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["svg_sprite"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/svg_sprite <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("svg_sprite", "svg_sprite", "1.0.3")
    BINSTUB
        chmod +x $dest/bin/svg_sprite
  '';
}
