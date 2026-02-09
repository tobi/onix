#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sdoc 2.6.4
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
  pname = "sdoc";
  version = "2.6.4";
  src = builtins.path {
    path = ./source;
    name = "sdoc-2.6.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/sdoc-2.6.4
        cp -r . $dest/gems/sdoc-2.6.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/sdoc-2.6.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "sdoc"
      s.version = "2.6.4"
      s.summary = "sdoc"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["sdoc", "sdoc-merge"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/sdoc <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("sdoc", "sdoc", "2.6.4")
    BINSTUB
        chmod +x $dest/bin/sdoc
        cat > $dest/bin/sdoc-merge <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("sdoc", "sdoc-merge", "2.6.4")
    BINSTUB
        chmod +x $dest/bin/sdoc-merge
  '';
}
