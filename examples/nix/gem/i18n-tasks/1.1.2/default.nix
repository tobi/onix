#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# i18n-tasks 1.1.2
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
  pname = "i18n-tasks";
  version = "1.1.2";
  src = builtins.path {
    path = ./source;
    name = "i18n-tasks-1.1.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/i18n-tasks-1.1.2
        cp -r . $dest/gems/i18n-tasks-1.1.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/i18n-tasks-1.1.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "i18n-tasks"
      s.version = "1.1.2"
      s.summary = "i18n-tasks"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["i18n-tasks"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/i18n-tasks <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("i18n-tasks", "i18n-tasks", "1.1.2")
    BINSTUB
        chmod +x $dest/bin/i18n-tasks
  '';
}
