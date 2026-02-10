#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fog 2.3.0
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
  pname = "fog";
  version = "2.3.0";
  src = builtins.path {
    path = ./source;
    name = "fog-2.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fog-2.3.0
        cp -r . $dest/gems/fog-2.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fog-2.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fog"
      s.version = "2.3.0"
      s.summary = "fog"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["fog"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/fog <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("fog", "fog", "2.3.0")
    BINSTUB
        chmod +x $dest/bin/fog
  '';
}
