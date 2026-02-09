#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# annotate 3.2.0
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
  pname = "annotate";
  version = "3.2.0";
  src = builtins.path {
    path = ./source;
    name = "annotate-3.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/annotate-3.2.0
        cp -r . $dest/gems/annotate-3.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/annotate-3.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "annotate"
      s.version = "3.2.0"
      s.summary = "annotate"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["annotate"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/annotate <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("annotate", "annotate", "3.2.0")
    BINSTUB
        chmod +x $dest/bin/annotate
  '';
}
