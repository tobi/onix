#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# railties 7.1.5.2
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
  pname = "railties";
  version = "7.1.5.2";
  src = builtins.path {
    path = ./source;
    name = "railties-7.1.5.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/railties-7.1.5.2
        cp -r . $dest/gems/railties-7.1.5.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/railties-7.1.5.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "railties"
      s.version = "7.1.5.2"
      s.summary = "railties"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["rails"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/rails <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("railties", "rails", "7.1.5.2")
    BINSTUB
        chmod +x $dest/bin/rails
  '';
}
