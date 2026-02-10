#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# test-unit 3.7.6
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
  pname = "test-unit";
  version = "3.7.6";
  src = builtins.path {
    path = ./source;
    name = "test-unit-3.7.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/test-unit-3.7.6
        cp -r . $dest/gems/test-unit-3.7.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/test-unit-3.7.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "test-unit"
      s.version = "3.7.6"
      s.summary = "test-unit"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["test-unit"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/test-unit <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("test-unit", "test-unit", "3.7.6")
    BINSTUB
        chmod +x $dest/bin/test-unit
  '';
}
