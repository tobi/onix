#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby_parser 3.21.0
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
  pname = "ruby_parser";
  version = "3.21.0";
  src = builtins.path {
    path = ./source;
    name = "ruby_parser-3.21.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ruby_parser-3.21.0
        cp -r . $dest/gems/ruby_parser-3.21.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ruby_parser-3.21.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ruby_parser"
      s.version = "3.21.0"
      s.summary = "ruby_parser"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["ruby_parse", "ruby_parse_extract_error"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/ruby_parse <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("ruby_parser", "ruby_parse", "3.21.0")
    BINSTUB
        chmod +x $dest/bin/ruby_parse
        cat > $dest/bin/ruby_parse_extract_error <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("ruby_parser", "ruby_parse_extract_error", "3.21.0")
    BINSTUB
        chmod +x $dest/bin/ruby_parse_extract_error
  '';
}
