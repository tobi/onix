#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fpm 1.16.0
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
  pname = "fpm";
  version = "1.16.0";
  src = builtins.path {
    path = ./source;
    name = "fpm-1.16.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fpm-1.16.0
        cp -r . $dest/gems/fpm-1.16.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fpm-1.16.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fpm"
      s.version = "1.16.0"
      s.summary = "fpm"
      s.require_paths = ["lib", "lib"]
      s.bindir = "bin"
      s.executables = ["fpm"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/fpm <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("fpm", "fpm", "1.16.0")
    BINSTUB
        chmod +x $dest/bin/fpm
  '';
}
