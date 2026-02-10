#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# wannabe_bool 0.7.1
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
  pname = "wannabe_bool";
  version = "0.7.1";
  src = builtins.path {
    path = ./source;
    name = "wannabe_bool-0.7.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/wannabe_bool-0.7.1
        cp -r . $dest/gems/wannabe_bool-0.7.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/wannabe_bool-0.7.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "wannabe_bool"
      s.version = "0.7.1"
      s.summary = "wannabe_bool"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["console"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/console <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("wannabe_bool", "console", "0.7.1")
    BINSTUB
        chmod +x $dest/bin/console
  '';
}
