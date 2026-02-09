#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ruby-readability 0.7.2
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
  pname = "ruby-readability";
  version = "0.7.2";
  src = builtins.path {
    path = ./source;
    name = "ruby-readability-0.7.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/ruby-readability-0.7.2
        cp -r . $dest/gems/ruby-readability-0.7.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ruby-readability-0.7.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ruby-readability"
      s.version = "0.7.2"
      s.summary = "ruby-readability"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["readability"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/readability <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("ruby-readability", "readability", "0.7.2")
    BINSTUB
        chmod +x $dest/bin/readability
  '';
}
