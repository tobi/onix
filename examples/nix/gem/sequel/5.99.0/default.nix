#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sequel 5.99.0
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
  pname = "sequel";
  version = "5.99.0";
  src = builtins.path {
    path = ./source;
    name = "sequel-5.99.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sequel-5.99.0
        cp -r . $dest/gems/sequel-5.99.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sequel-5.99.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sequel"
      s.version = "5.99.0"
      s.summary = "sequel"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["sequel"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/sequel <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("sequel", "sequel", "5.99.0")
    BINSTUB
        chmod +x $dest/bin/sequel
  '';
}
