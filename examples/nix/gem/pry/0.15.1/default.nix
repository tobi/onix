#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pry 0.15.1
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
  pname = "pry";
  version = "0.15.1";
  src = builtins.path {
    path = ./source;
    name = "pry-0.15.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/pry-0.15.1
        cp -r . $dest/gems/pry-0.15.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/pry-0.15.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "pry"
      s.version = "0.15.1"
      s.summary = "pry"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["pry"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/pry <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("pry", "pry", "0.15.1")
    BINSTUB
        chmod +x $dest/bin/pry
  '';
}
