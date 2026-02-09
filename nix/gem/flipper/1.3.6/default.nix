#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flipper 1.3.6
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
  pname = "flipper";
  version = "1.3.6";
  src = builtins.path {
    path = ./source;
    name = "flipper-1.3.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/flipper-1.3.6
        cp -r . $dest/gems/flipper-1.3.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/flipper-1.3.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "flipper"
      s.version = "1.3.6"
      s.summary = "flipper"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["flipper"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/flipper <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("flipper", "flipper", "1.3.6")
    BINSTUB
        chmod +x $dest/bin/flipper
  '';
}
