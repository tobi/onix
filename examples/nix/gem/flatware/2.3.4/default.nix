#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flatware 2.3.4
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
  pname = "flatware";
  version = "2.3.4";
  src = builtins.path {
    path = ./source;
    name = "flatware-2.3.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/flatware-2.3.4
        cp -r . $dest/gems/flatware-2.3.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/flatware-2.3.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "flatware"
      s.version = "2.3.4"
      s.summary = "flatware"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["flatware"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/flatware <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("flatware", "flatware", "2.3.4")
    BINSTUB
        chmod +x $dest/bin/flatware
  '';
}
