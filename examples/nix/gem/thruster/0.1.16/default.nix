#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# thruster 0.1.16
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
  pname = "thruster";
  version = "0.1.16";
  src = builtins.path {
    path = ./source;
    name = "thruster-0.1.16-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/thruster-0.1.16
        cp -r . $dest/gems/thruster-0.1.16/
        mkdir -p $dest/specifications
        cat > $dest/specifications/thruster-0.1.16.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "thruster"
      s.version = "0.1.16"
      s.summary = "thruster"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["thrust"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/thrust <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("thruster", "thrust", "0.1.16")
    BINSTUB
        chmod +x $dest/bin/thrust
  '';
}
