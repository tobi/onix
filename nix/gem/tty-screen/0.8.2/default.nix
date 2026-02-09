#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tty-screen 0.8.2
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
  pname = "tty-screen";
  version = "0.8.2";
  src = builtins.path {
    path = ./source;
    name = "tty-screen-0.8.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/tty-screen-0.8.2
        cp -r . $dest/gems/tty-screen-0.8.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/tty-screen-0.8.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "tty-screen"
      s.version = "0.8.2"
      s.summary = "tty-screen"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
