#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# thor 1.3.2
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
  pname = "thor";
  version = "1.3.2";
  src = builtins.path {
    path = ./source;
    name = "thor-1.3.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/thor-1.3.2
        cp -r . $dest/gems/thor-1.3.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/thor-1.3.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "thor"
      s.version = "1.3.2"
      s.summary = "thor"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["thor"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/thor <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("thor", "thor", "1.3.2")
    BINSTUB
        chmod +x $dest/bin/thor
  '';
}
