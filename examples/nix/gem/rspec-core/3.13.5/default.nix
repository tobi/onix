#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-core 3.13.5
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
  pname = "rspec-core";
  version = "3.13.5";
  src = builtins.path {
    path = ./source;
    name = "rspec-core-3.13.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rspec-core-3.13.5
        cp -r . $dest/gems/rspec-core-3.13.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rspec-core-3.13.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rspec-core"
      s.version = "3.13.5"
      s.summary = "rspec-core"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["rspec"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/rspec <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rspec-core", "rspec", "3.13.5")
    BINSTUB
        chmod +x $dest/bin/rspec
  '';
}
