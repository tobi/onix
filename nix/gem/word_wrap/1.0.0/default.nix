#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# word_wrap 1.0.0
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
  pname = "word_wrap";
  version = "1.0.0";
  src = builtins.path {
    path = ./source;
    name = "word_wrap-1.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/word_wrap-1.0.0
        cp -r . $dest/gems/word_wrap-1.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/word_wrap-1.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "word_wrap"
      s.version = "1.0.0"
      s.summary = "word_wrap"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["ww"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/ww <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("word_wrap", "ww", "1.0.0")
    BINSTUB
        chmod +x $dest/bin/ww
  '';
}
