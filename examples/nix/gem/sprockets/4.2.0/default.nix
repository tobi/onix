#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sprockets 4.2.0
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
  pname = "sprockets";
  version = "4.2.0";
  src = builtins.path {
    path = ./source;
    name = "sprockets-4.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sprockets-4.2.0
        cp -r . $dest/gems/sprockets-4.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sprockets-4.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sprockets"
      s.version = "4.2.0"
      s.summary = "sprockets"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["sprockets"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/sprockets <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("sprockets", "sprockets", "4.2.0")
    BINSTUB
        chmod +x $dest/bin/sprockets
  '';
}
