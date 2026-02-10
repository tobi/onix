#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# premailer 1.26.0
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
  pname = "premailer";
  version = "1.26.0";
  src = builtins.path {
    path = ./source;
    name = "premailer-1.26.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/premailer-1.26.0
        cp -r . $dest/gems/premailer-1.26.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/premailer-1.26.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "premailer"
      s.version = "1.26.0"
      s.summary = "premailer"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["premailer"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/premailer <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("premailer", "premailer", "1.26.0")
    BINSTUB
        chmod +x $dest/bin/premailer
  '';
}
