#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# haml 7.1.0
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
  pname = "haml";
  version = "7.1.0";
  src = builtins.path {
    path = ./source;
    name = "haml-7.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/haml-7.1.0
        cp -r . $dest/gems/haml-7.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/haml-7.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "haml"
      s.version = "7.1.0"
      s.summary = "haml"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["haml"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/haml <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("haml", "haml", "7.1.0")
    BINSTUB
        chmod +x $dest/bin/haml
  '';
}
