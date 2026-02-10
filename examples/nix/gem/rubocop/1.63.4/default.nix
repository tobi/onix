#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop 1.63.4
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
  pname = "rubocop";
  version = "1.63.4";
  src = builtins.path {
    path = ./source;
    name = "rubocop-1.63.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rubocop-1.63.4
        cp -r . $dest/gems/rubocop-1.63.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rubocop-1.63.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rubocop"
      s.version = "1.63.4"
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
    load Gem.bin_path("rubocop", "rubocop", "1.63.4")
    BINSTUB
        chmod +x $dest/bin/rubocop
  '';
}
