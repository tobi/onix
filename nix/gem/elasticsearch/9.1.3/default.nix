#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# elasticsearch 9.1.3
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
  pname = "elasticsearch";
  version = "9.1.3";
  src = builtins.path {
    path = ./source;
    name = "elasticsearch-9.1.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/elasticsearch-9.1.3
        cp -r . $dest/gems/elasticsearch-9.1.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/elasticsearch-9.1.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "elasticsearch"
      s.version = "9.1.3"
      s.summary = "elasticsearch"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["elastic_ruby_console"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/elastic_ruby_console <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("elasticsearch", "elastic_ruby_console", "9.1.3")
    BINSTUB
        chmod +x $dest/bin/elastic_ruby_console
  '';
}
