#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# unparser 0.8.1
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
  pname = "unparser";
  version = "0.8.1";
  src = builtins.path {
    path = ./source;
    name = "unparser-0.8.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/unparser-0.8.1
        cp -r . $dest/gems/unparser-0.8.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/unparser-0.8.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "unparser"
      s.version = "0.8.1"
      s.summary = "unparser"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["unparser"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/unparser <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("unparser", "unparser", "0.8.1")
    BINSTUB
        chmod +x $dest/bin/unparser
  '';
}
