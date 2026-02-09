#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# commander 4.5.2
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
  pname = "commander";
  version = "4.5.2";
  src = builtins.path {
    path = ./source;
    name = "commander-4.5.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/commander-4.5.2
        cp -r . $dest/gems/commander-4.5.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/commander-4.5.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "commander"
      s.version = "4.5.2"
      s.summary = "commander"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["commander"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/commander <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("commander", "commander", "4.5.2")
    BINSTUB
        chmod +x $dest/bin/commander
  '';
}
