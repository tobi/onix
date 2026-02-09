#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opensearch-ruby 3.4.0
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
  pname = "opensearch-ruby";
  version = "3.4.0";
  src = builtins.path {
    path = ./source;
    name = "opensearch-ruby-3.4.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/opensearch-ruby-3.4.0
        cp -r . $dest/gems/opensearch-ruby-3.4.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/opensearch-ruby-3.4.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "opensearch-ruby"
      s.version = "3.4.0"
      s.summary = "opensearch-ruby"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["opensearch_ruby_console"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/opensearch_ruby_console <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("opensearch-ruby", "opensearch_ruby_console", "3.4.0")
    BINSTUB
        chmod +x $dest/bin/opensearch_ruby_console
  '';
}
