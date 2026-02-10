#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# parser 3.3.1.0
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
  pname = "parser";
  version = "3.3.1.0";
  src = builtins.path {
    path = ./source;
    name = "parser-3.3.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/parser-3.3.1.0
        cp -r . $dest/gems/parser-3.3.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/parser-3.3.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "parser"
      s.version = "3.3.1.0"
      s.summary = "parser"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["ruby-parse", "ruby-rewrite"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/ruby-parse <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("parser", "ruby-parse", "3.3.1.0")
    BINSTUB
        chmod +x $dest/bin/ruby-parse
        cat > $dest/bin/ruby-rewrite <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("parser", "ruby-rewrite", "3.3.1.0")
    BINSTUB
        chmod +x $dest/bin/ruby-rewrite
  '';
}
