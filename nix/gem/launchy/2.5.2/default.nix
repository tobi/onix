#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# launchy 2.5.2
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
  version = "2.5.2";
  src = builtins.path {
    path = ./source;
    name = "launchy-2.5.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/launchy-2.5.2
        cp -r . $dest/gems/launchy-2.5.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/launchy-2.5.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "launchy"
      s.version = "2.5.2"
      s.summary = "launchy"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["launchy"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/launchy <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("launchy", "launchy", "2.5.2")
    BINSTUB
        chmod +x $dest/bin/launchy
  '';
}
