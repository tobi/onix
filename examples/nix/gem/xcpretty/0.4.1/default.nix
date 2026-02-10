#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# xcpretty 0.4.1
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
  pname = "xcpretty";
  version = "0.4.1";
  src = builtins.path {
    path = ./source;
    name = "xcpretty-0.4.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/xcpretty-0.4.1
        cp -r . $dest/gems/xcpretty-0.4.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/xcpretty-0.4.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "xcpretty"
      s.version = "0.4.1"
      s.summary = "xcpretty"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["xcpretty"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/xcpretty <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("xcpretty", "xcpretty", "0.4.1")
    BINSTUB
        chmod +x $dest/bin/xcpretty
  '';
}
