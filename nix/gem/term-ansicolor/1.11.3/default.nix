#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# term-ansicolor 1.11.3
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
  pname = "term-ansicolor";
  version = "1.11.3";
  src = builtins.path {
    path = ./source;
    name = "term-ansicolor-1.11.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/term-ansicolor-1.11.3
        cp -r . $dest/gems/term-ansicolor-1.11.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/term-ansicolor-1.11.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "term-ansicolor"
      s.version = "1.11.3"
      s.summary = "term-ansicolor"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["term_cdiff", "term_colortab", "term_decolor", "term_display", "term_mandel", "term_plasma", "term_snow"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/term_cdiff <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("term-ansicolor", "term_cdiff", "1.11.3")
    BINSTUB
        chmod +x $dest/bin/term_cdiff
        cat > $dest/bin/term_colortab <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("term-ansicolor", "term_colortab", "1.11.3")
    BINSTUB
        chmod +x $dest/bin/term_colortab
        cat > $dest/bin/term_decolor <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("term-ansicolor", "term_decolor", "1.11.3")
    BINSTUB
        chmod +x $dest/bin/term_decolor
        cat > $dest/bin/term_display <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("term-ansicolor", "term_display", "1.11.3")
    BINSTUB
        chmod +x $dest/bin/term_display
        cat > $dest/bin/term_mandel <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("term-ansicolor", "term_mandel", "1.11.3")
    BINSTUB
        chmod +x $dest/bin/term_mandel
        cat > $dest/bin/term_plasma <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("term-ansicolor", "term_plasma", "1.11.3")
    BINSTUB
        chmod +x $dest/bin/term_plasma
        cat > $dest/bin/term_snow <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("term-ansicolor", "term_snow", "1.11.3")
    BINSTUB
        chmod +x $dest/bin/term_snow
  '';
}
