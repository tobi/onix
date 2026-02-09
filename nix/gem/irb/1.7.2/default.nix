#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# irb 1.7.2
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
  pname = "irb";
  version = "1.7.2";
  src = builtins.path {
    path = ./source;
    name = "irb-1.7.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/irb-1.7.2
        cp -r . $dest/gems/irb-1.7.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/irb-1.7.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "irb"
      s.version = "1.7.2"
      s.summary = "irb"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["irb"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/irb <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("irb", "irb", "1.7.2")
    BINSTUB
        chmod +x $dest/bin/irb
  '';
}
