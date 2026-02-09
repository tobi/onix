#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# backburner 1.7.0
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
  pname = "backburner";
  version = "1.7.0";
  src = builtins.path {
    path = ./source;
    name = "backburner-1.7.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/backburner-1.7.0
        cp -r . $dest/gems/backburner-1.7.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/backburner-1.7.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "backburner"
      s.version = "1.7.0"
      s.summary = "backburner"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["backburner"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/backburner <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("backburner", "backburner", "1.7.0")
    BINSTUB
        chmod +x $dest/bin/backburner
  '';
}
