#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rdf 3.3.4
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
  pname = "rdf";
  version = "3.3.4";
  src = builtins.path {
    path = ./source;
    name = "rdf-3.3.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rdf-3.3.4
        cp -r . $dest/gems/rdf-3.3.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rdf-3.3.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rdf"
      s.version = "3.3.4"
      s.summary = "rdf"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["rdf"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/rdf <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rdf", "rdf", "3.3.4")
    BINSTUB
        chmod +x $dest/bin/rdf
  '';
}
