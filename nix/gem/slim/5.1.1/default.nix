#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# slim 5.1.1
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
  pname = "slim";
  version = "5.1.1";
  src = builtins.path {
    path = ./source;
    name = "slim-5.1.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/slim-5.1.1
        cp -r . $dest/gems/slim-5.1.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/slim-5.1.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "slim"
      s.version = "5.1.1"
      s.summary = "slim"
      s.require_paths = ["lib"]
      s.bindir = "bin"
      s.executables = ["slimrb"]
      s.files = []
    end
    EOF
        mkdir -p $dest/bin
        cat > $dest/bin/slimrb <<'BINSTUB'
    #!/usr/bin/env ruby
    require "rubygems"
    load Gem.bin_path("slim", "slimrb", "5.1.1")
    BINSTUB
        chmod +x $dest/bin/slimrb
  '';
}
