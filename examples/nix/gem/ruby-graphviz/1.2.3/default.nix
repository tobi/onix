#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-graphviz 1.2.3
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
  pname = "ruby-graphviz";
  version = "1.2.3";
  src = builtins.path {
    path = ./source;
    name = "ruby-graphviz-1.2.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ruby-graphviz-1.2.3
        cp -r . $dest/gems/ruby-graphviz-1.2.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ruby-graphviz-1.2.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ruby-graphviz"
      s.version = "1.2.3"
      s.summary = "ruby-graphviz"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["dot2ruby", "gem2gv", "git2gv", "ruby2gv", "xml2gv"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/dot2ruby <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("ruby-graphviz", "dot2ruby", "1.2.3")
    BINSTUB
        chmod +x $dest/bin/dot2ruby
        cat > $dest/bin/gem2gv <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("ruby-graphviz", "gem2gv", "1.2.3")
    BINSTUB
        chmod +x $dest/bin/gem2gv
        cat > $dest/bin/git2gv <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("ruby-graphviz", "git2gv", "1.2.3")
    BINSTUB
        chmod +x $dest/bin/git2gv
        cat > $dest/bin/ruby2gv <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("ruby-graphviz", "ruby2gv", "1.2.3")
    BINSTUB
        chmod +x $dest/bin/ruby2gv
        cat > $dest/bin/xml2gv <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("ruby-graphviz", "xml2gv", "1.2.3")
    BINSTUB
        chmod +x $dest/bin/xml2gv
  '';
}
