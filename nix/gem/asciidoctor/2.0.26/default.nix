#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# asciidoctor 2.0.26
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
  pname = "asciidoctor";
  version = "2.0.26";
  src = builtins.path {
    path = ./source;
    name = "asciidoctor-2.0.26-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/asciidoctor-2.0.26
        cp -r . $dest/gems/asciidoctor-2.0.26/
        mkdir -p $dest/specifications
        cat > $dest/specifications/asciidoctor-2.0.26.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "asciidoctor"
      s.version = "2.0.26"
      s.summary = "asciidoctor"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["asciidoctor"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/asciidoctor <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("asciidoctor", "asciidoctor", "2.0.26")
    BINSTUB
        chmod +x $dest/bin/asciidoctor
  '';
}
