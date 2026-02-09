#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# wisper 2.0.1
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "wisper";
  version = "2.0.1";
  src = builtins.path {
    path = ./source;
    name = "wisper-2.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/wisper-2.0.1
        cp -r . $dest/gems/wisper-2.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/wisper-2.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "wisper"
      s.version = "2.0.1"
      s.summary = "wisper"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["console", "setup"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/console <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("wisper", "console", "2.0.1")
    BINSTUB
        chmod +x $dest/bin/console
        cat > $dest/bin/setup <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("wisper", "setup", "2.0.1")
    BINSTUB
        chmod +x $dest/bin/setup
  '';
}
