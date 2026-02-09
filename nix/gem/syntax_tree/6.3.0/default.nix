#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# syntax_tree 6.3.0
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
  pname = "syntax_tree";
  version = "6.3.0";
  src = builtins.path {
    path = ./source;
    name = "syntax_tree-6.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/syntax_tree-6.3.0
        cp -r . $dest/gems/syntax_tree-6.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/syntax_tree-6.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "syntax_tree"
      s.version = "6.3.0"
      s.summary = "syntax_tree"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["stree", "yarv"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/stree <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("syntax_tree", "stree", "6.3.0")
    BINSTUB
        chmod +x $dest/bin/stree
        cat > $dest/bin/yarv <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("syntax_tree", "yarv", "6.3.0")
    BINSTUB
        chmod +x $dest/bin/yarv
  '';
}
