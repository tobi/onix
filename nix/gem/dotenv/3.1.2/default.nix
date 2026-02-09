#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dotenv 3.1.2
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
  pname = "dotenv";
  version = "3.1.2";
  src = builtins.path {
    path = ./source;
    name = "dotenv-3.1.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/dotenv-3.1.2
        cp -r . $dest/gems/dotenv-3.1.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/dotenv-3.1.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "dotenv"
      s.version = "3.1.2"
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
    load Gem.bin_path("dotenv", "dotenv", "3.1.2")
    BINSTUB
        chmod +x $dest/bin/dotenv
  '';
}
