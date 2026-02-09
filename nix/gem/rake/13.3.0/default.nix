#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rake 13.3.0
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
  pname = "rake";
  version = "13.3.0";
  src = builtins.path {
    path = ./source;
    name = "rake-13.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rake-13.3.0
        cp -r . $dest/gems/rake-13.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rake-13.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rake"
      s.version = "13.3.0"
      s.summary = "rake"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["rake"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/rake <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rake", "rake", "13.3.0")
    BINSTUB
        chmod +x $dest/bin/rake
  '';
}
