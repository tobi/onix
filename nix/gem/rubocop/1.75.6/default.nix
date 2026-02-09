#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop 1.75.6
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
  pname = "rubocop";
  version = "1.75.6";
  src = builtins.path {
    path = ./source;
    name = "rubocop-1.75.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/rubocop-1.75.6
        cp -r . $dest/gems/rubocop-1.75.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rubocop-1.75.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rubocop"
      s.version = "1.75.6"
      s.summary = "rubocop"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["rubocop"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/rubocop <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rubocop", "rubocop", "1.75.6")
    BINSTUB
        chmod +x $dest/bin/rubocop
  '';
}
