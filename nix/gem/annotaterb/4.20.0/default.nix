#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# annotaterb 4.20.0
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
  pname = "annotaterb";
  version = "4.20.0";
  src = builtins.path {
    path = ./source;
    name = "annotaterb-4.20.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/annotaterb-4.20.0
        cp -r . $dest/gems/annotaterb-4.20.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/annotaterb-4.20.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "annotaterb"
      s.version = "4.20.0"
      s.summary = "annotaterb"
      s.require_paths = ["lib"]
      s.bindir = "exe"
      s.executables = ["annotaterb"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/annotaterb <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("annotaterb", "annotaterb", "4.20.0")
    BINSTUB
        chmod +x $dest/bin/annotaterb
  '';
}
