#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# geocoder 1.8.5
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
  pname = "geocoder";
  version = "1.8.5";
  src = builtins.path {
    path = ./source;
    name = "geocoder-1.8.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/geocoder-1.8.5
        cp -r . $dest/gems/geocoder-1.8.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/geocoder-1.8.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "geocoder"
      s.version = "1.8.5"
      s.summary = "geocoder"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["geocode"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/geocode <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("geocoder", "geocode", "1.8.5")
    BINSTUB
        chmod +x $dest/bin/geocode
  '';
}
