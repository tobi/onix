#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pdf-reader 2.15.0
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "pdf-reader";
  version = "2.15.0";
  src = builtins.path {
    path = ./source;
    name = "pdf-reader-2.15.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/pdf-reader-2.15.0
        cp -r . $dest/gems/pdf-reader-2.15.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/pdf-reader-2.15.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "pdf-reader"
      s.version = "2.15.0"
      s.summary = "pdf-reader"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["pdf_callbacks", "pdf_object", "pdf_text"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/pdf_callbacks <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("pdf-reader", "pdf_callbacks", "2.15.0")
    BINSTUB
        chmod +x $dest/bin/pdf_callbacks
        cat > $dest/bin/pdf_object <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("pdf-reader", "pdf_object", "2.15.0")
    BINSTUB
        chmod +x $dest/bin/pdf_object
        cat > $dest/bin/pdf_text <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("pdf-reader", "pdf_text", "2.15.0")
    BINSTUB
        chmod +x $dest/bin/pdf_text
  '';
}
