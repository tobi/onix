#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rake-compiler-dock 1.10.0
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
  pname = "rake-compiler-dock";
  version = "1.10.0";
  src = builtins.path {
    path = ./source;
    name = "rake-compiler-dock-1.10.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rake-compiler-dock-1.10.0
        cp -r . $dest/gems/rake-compiler-dock-1.10.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rake-compiler-dock-1.10.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rake-compiler-dock"
      s.version = "1.10.0"
      s.summary = "rake-compiler-dock"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["rake-compiler-dock"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/rake-compiler-dock <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rake-compiler-dock", "rake-compiler-dock", "1.10.0")
    BINSTUB
        chmod +x $dest/bin/rake-compiler-dock
  '';
}
