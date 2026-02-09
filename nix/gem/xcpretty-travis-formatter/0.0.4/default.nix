#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# xcpretty-travis-formatter 0.0.4
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
  pname = "xcpretty-travis-formatter";
  version = "0.0.4";
  src = builtins.path {
    path = ./source;
    name = "xcpretty-travis-formatter-0.0.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/xcpretty-travis-formatter-0.0.4
        cp -r . $dest/gems/xcpretty-travis-formatter-0.0.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/xcpretty-travis-formatter-0.0.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "xcpretty-travis-formatter"
      s.version = "0.0.4"
      s.summary = "xcpretty-travis-formatter"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["xcpretty-travis-formatter"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/xcpretty-travis-formatter <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("xcpretty-travis-formatter", "xcpretty-travis-formatter", "0.0.4")
    BINSTUB
        chmod +x $dest/bin/xcpretty-travis-formatter
  '';
}
