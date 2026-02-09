#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fuzzy_match 2.0.4
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
  version = "2.0.4";
  src = builtins.path {
    path = ./source;
    name = "fuzzy_match-2.0.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fuzzy_match-2.0.4
        cp -r . $dest/gems/fuzzy_match-2.0.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fuzzy_match-2.0.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fuzzy_match"
      s.version = "2.0.4"
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
    load Gem.bin_path("fuzzy_match", "fuzzy_match", "2.0.4")
    BINSTUB
        chmod +x $dest/bin/fuzzy_match
  '';
}
