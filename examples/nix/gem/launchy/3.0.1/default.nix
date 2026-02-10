#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# launchy 3.0.1
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
  pname = "launchy";
  version = "3.0.1";
  src = builtins.path {
    path = ./source;
    name = "launchy-3.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/launchy-3.0.1
        cp -r . $dest/gems/launchy-3.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/launchy-3.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "launchy"
      s.version = "3.0.1"
      s.summary = "launchy"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["launchy"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/launchy <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("launchy", "launchy", "3.0.1")
    BINSTUB
        chmod +x $dest/bin/launchy
  '';
}
