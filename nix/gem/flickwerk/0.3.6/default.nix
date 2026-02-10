#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flickwerk 0.3.6
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
  pname = "flickwerk";
  version = "0.3.6";
  src = builtins.path {
    path = ./source;
    name = "flickwerk-0.3.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/flickwerk-0.3.6
        cp -r . $dest/gems/flickwerk-0.3.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/flickwerk-0.3.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "flickwerk"
      s.version = "0.3.6"
      s.summary = "flickwerk"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["flickwerk"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/flickwerk <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("flickwerk", "flickwerk", "0.3.6")
    BINSTUB
        chmod +x $dest/bin/flickwerk
  '';
}
