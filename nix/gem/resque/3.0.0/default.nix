#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# resque 3.0.0
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
  pname = "resque";
  version = "3.0.0";
  src = builtins.path {
    path = ./source;
    name = "resque-3.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/resque-3.0.0
        cp -r . $dest/gems/resque-3.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/resque-3.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "resque"
      s.version = "3.0.0"
      s.summary = "resque"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["resque", "resque-web"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/resque <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("resque", "resque", "3.0.0")
    BINSTUB
        chmod +x $dest/bin/resque
        cat > $dest/bin/resque-web <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("resque", "resque-web", "3.0.0")
    BINSTUB
        chmod +x $dest/bin/resque-web
  '';
}
