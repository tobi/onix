#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# erubis 2.7.0
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
  pname = "erubis";
  version = "2.7.0";
  src = builtins.path {
    path = ./source;
    name = "erubis-2.7.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/erubis-2.7.0
        cp -r . $dest/gems/erubis-2.7.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/erubis-2.7.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "erubis"
      s.version = "2.7.0"
      s.summary = "erubis"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["erubis"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/erubis <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("erubis", "erubis", "2.7.0")
    BINSTUB
        chmod +x $dest/bin/erubis
  '';
}
