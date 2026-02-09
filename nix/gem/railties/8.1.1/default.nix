#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# railties 8.1.1
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
  pname = "railties";
  version = "8.1.1";
  src = builtins.path {
    path = ./source;
    name = "railties-8.1.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/railties-8.1.1
        cp -r . $dest/gems/railties-8.1.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/railties-8.1.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "railties"
      s.version = "8.1.1"
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
    load Gem.bin_path("railties", "rails", "8.1.1")
    BINSTUB
        chmod +x $dest/bin/rails
  '';
}
