#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fuzzy_match 2.1.0
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
  pname = "fuzzy_match";
  version = "2.1.0";
  src = builtins.path {
    path = ./source;
    name = "fuzzy_match-2.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fuzzy_match-2.1.0
        cp -r . $dest/gems/fuzzy_match-2.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fuzzy_match-2.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fuzzy_match"
      s.version = "2.1.0"
      s.summary = "fuzzy_match"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["fuzzy_match"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/fuzzy_match <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("fuzzy_match", "fuzzy_match", "2.1.0")
    BINSTUB
        chmod +x $dest/bin/fuzzy_match
  '';
}
