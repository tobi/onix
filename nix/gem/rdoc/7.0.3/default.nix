#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rdoc 7.0.3
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
  pname = "rdoc";
  version = "7.0.3";
  src = builtins.path {
    path = ./source;
    name = "rdoc-7.0.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/rdoc-7.0.3
        cp -r . $dest/gems/rdoc-7.0.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rdoc-7.0.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rdoc"
      s.version = "7.0.3"
      s.summary = "rdoc"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["rdoc", "ri"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/rdoc <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rdoc", "rdoc", "7.0.3")
    BINSTUB
        chmod +x $dest/bin/rdoc
        cat > $dest/bin/ri <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rdoc", "ri", "7.0.3")
    BINSTUB
        chmod +x $dest/bin/ri
  '';
}
