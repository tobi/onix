#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# resque-scheduler 4.11.0
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
  pname = "resque-scheduler";
  version = "4.11.0";
  src = builtins.path {
    path = ./source;
    name = "resque-scheduler-4.11.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/resque-scheduler-4.11.0
        cp -r . $dest/gems/resque-scheduler-4.11.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/resque-scheduler-4.11.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "resque-scheduler"
      s.version = "4.11.0"
      s.summary = "resque-scheduler"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["resque-scheduler"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/resque-scheduler <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("resque-scheduler", "resque-scheduler", "4.11.0")
    BINSTUB
        chmod +x $dest/bin/resque-scheduler
  '';
}
