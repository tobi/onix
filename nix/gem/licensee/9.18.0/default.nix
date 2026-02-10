#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# licensee 9.18.0
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
  pname = "licensee";
  version = "9.18.0";
  src = builtins.path {
    path = ./source;
    name = "licensee-9.18.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/licensee-9.18.0
        cp -r . $dest/gems/licensee-9.18.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/licensee-9.18.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "licensee"
      s.version = "9.18.0"
      s.summary = "licensee"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["licensee"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/licensee <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("licensee", "licensee", "9.18.0")
    BINSTUB
        chmod +x $dest/bin/licensee
  '';
}
