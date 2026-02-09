#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rotp 6.3.0
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
  pname = "rotp";
  version = "6.3.0";
  src = builtins.path {
    path = ./source;
    name = "rotp-6.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/rotp-6.3.0
        cp -r . $dest/gems/rotp-6.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rotp-6.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rotp"
      s.version = "6.3.0"
      s.summary = "rotp"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["rotp"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/rotp <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("rotp", "rotp", "6.3.0")
    BINSTUB
        chmod +x $dest/bin/rotp
  '';
}
