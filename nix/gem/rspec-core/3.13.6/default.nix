#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-core 3.13.6
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
  pname = "rspec-core";
  version = "3.13.6";
  src = builtins.path {
    path = ./source;
    name = "rspec-core-3.13.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/rspec-core-3.13.6
        cp -r . $dest/gems/rspec-core-3.13.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rspec-core-3.13.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rspec-core"
      s.version = "3.13.6"
      s.summary = "rspec-core"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["rspec"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/rspec <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rspec-core", "rspec", "3.13.6")
    BINSTUB
        chmod +x $dest/bin/rspec
  '';
}
