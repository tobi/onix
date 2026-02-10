#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sass 3.7.3
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
  pname = "sass";
  version = "3.7.3";
  src = builtins.path {
    path = ./source;
    name = "sass-3.7.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sass-3.7.3
        cp -r . $dest/gems/sass-3.7.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sass-3.7.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sass"
      s.version = "3.7.3"
      s.summary = "sass"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["sass", "sass-convert", "scss"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/sass <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("sass", "sass", "3.7.3")
    BINSTUB
        chmod +x $dest/bin/sass
        cat > $dest/bin/sass-convert <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("sass", "sass-convert", "3.7.3")
    BINSTUB
        chmod +x $dest/bin/sass-convert
        cat > $dest/bin/scss <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("sass", "scss", "3.7.3")
    BINSTUB
        chmod +x $dest/bin/scss
  '';
}
