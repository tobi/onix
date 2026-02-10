#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cucumber 10.1.0
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
  pname = "cucumber";
  version = "10.1.0";
  src = builtins.path {
    path = ./source;
    name = "cucumber-10.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/cucumber-10.1.0
        cp -r . $dest/gems/cucumber-10.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/cucumber-10.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "cucumber"
      s.version = "10.1.0"
      s.summary = "cucumber"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["cucumber"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/cucumber <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("cucumber", "cucumber", "10.1.0")
    BINSTUB
        chmod +x $dest/bin/cucumber
  '';
}
