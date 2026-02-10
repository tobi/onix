#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# vite_ruby 3.8.0
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
  pname = "vite_ruby";
  version = "3.8.0";
  src = builtins.path {
    path = ./source;
    name = "vite_ruby-3.8.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/vite_ruby-3.8.0
        cp -r . $dest/gems/vite_ruby-3.8.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/vite_ruby-3.8.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "vite_ruby"
      s.version = "3.8.0"
      s.summary = "vite_ruby"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["vite"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/vite <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("vite_ruby", "vite", "3.8.0")
    BINSTUB
        chmod +x $dest/bin/vite
  '';
}
