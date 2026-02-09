#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# brakeman 8.0.1
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
  pname = "brakeman";
  version = "8.0.1";
  src = builtins.path {
    path = ./source;
    name = "brakeman-8.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/brakeman-8.0.1
        cp -r . $dest/gems/brakeman-8.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/brakeman-8.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "brakeman"
      s.version = "8.0.1"
      s.summary = "brakeman"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["brakeman"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/brakeman <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("brakeman", "brakeman", "8.0.1")
    BINSTUB
        chmod +x $dest/bin/brakeman
  '';
}
