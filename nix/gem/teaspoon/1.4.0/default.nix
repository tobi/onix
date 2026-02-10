#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# teaspoon 1.4.0
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
  pname = "teaspoon";
  version = "1.4.0";
  src = builtins.path {
    path = ./source;
    name = "teaspoon-1.4.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/teaspoon-1.4.0
        cp -r . $dest/gems/teaspoon-1.4.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/teaspoon-1.4.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "teaspoon"
      s.version = "1.4.0"
      s.summary = "teaspoon"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["teaspoon"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/teaspoon <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("teaspoon", "teaspoon", "1.4.0")
    BINSTUB
        chmod +x $dest/bin/teaspoon
  '';
}
