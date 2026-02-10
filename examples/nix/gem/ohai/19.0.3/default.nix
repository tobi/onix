#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ohai 19.0.3
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
  pname = "ohai";
  version = "19.0.3";
  src = builtins.path {
    path = ./source;
    name = "ohai-19.0.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ohai-19.0.3
        cp -r . $dest/gems/ohai-19.0.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ohai-19.0.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ohai"
      s.version = "19.0.3"
      s.summary = "ohai"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["ohai"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/ohai <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("ohai", "ohai", "19.0.3")
    BINSTUB
        chmod +x $dest/bin/ohai
  '';
}
