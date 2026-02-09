#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dotenv 3.2.0
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
  pname = "dotenv";
  version = "3.2.0";
  src = builtins.path {
    path = ./source;
    name = "dotenv-3.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/dotenv-3.2.0
        cp -r . $dest/gems/dotenv-3.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/dotenv-3.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "dotenv"
      s.version = "3.2.0"
      s.summary = "dotenv"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["dotenv"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/dotenv <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("dotenv", "dotenv", "3.2.0")
    BINSTUB
        chmod +x $dest/bin/dotenv
  '';
}
