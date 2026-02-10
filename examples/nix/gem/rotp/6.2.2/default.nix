#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rotp 6.2.2
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
  pname = "rotp";
  version = "6.2.2";
  src = builtins.path {
    path = ./source;
    name = "rotp-6.2.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rotp-6.2.2
        cp -r . $dest/gems/rotp-6.2.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rotp-6.2.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rotp"
      s.version = "6.2.2"
      s.summary = "rotp"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["rotp"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/rotp <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rotp", "rotp", "6.2.2")
    BINSTUB
        chmod +x $dest/bin/rotp
  '';
}
