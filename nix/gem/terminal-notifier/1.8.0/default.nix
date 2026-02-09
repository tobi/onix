#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# terminal-notifier 1.8.0
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
  pname = "terminal-notifier";
  version = "1.8.0";
  src = builtins.path {
    path = ./source;
    name = "terminal-notifier-1.8.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/terminal-notifier-1.8.0
        cp -r . $dest/gems/terminal-notifier-1.8.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/terminal-notifier-1.8.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "terminal-notifier"
      s.version = "1.8.0"
      s.summary = "terminal-notifier"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["terminal-notifier"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/terminal-notifier <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("terminal-notifier", "terminal-notifier", "1.8.0")
    BINSTUB
        chmod +x $dest/bin/terminal-notifier
  '';
}
