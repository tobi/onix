#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# whenever 1.1.1
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
  pname = "whenever";
  version = "1.1.1";
  src = builtins.path {
    path = ./source;
    name = "whenever-1.1.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/whenever-1.1.1
        cp -r . $dest/gems/whenever-1.1.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/whenever-1.1.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "whenever"
      s.version = "1.1.1"
      s.summary = "whenever"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["whenever", "wheneverize"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/whenever <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("whenever", "whenever", "1.1.1")
    BINSTUB
        chmod +x $dest/bin/whenever
        cat > $dest/bin/wheneverize <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("whenever", "wheneverize", "1.1.1")
    BINSTUB
        chmod +x $dest/bin/wheneverize
  '';
}
