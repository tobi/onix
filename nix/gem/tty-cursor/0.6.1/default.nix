#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tty-cursor 0.6.1
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
  pname = "tty-cursor";
  version = "0.6.1";
  src = builtins.path {
    path = ./source;
    name = "tty-cursor-0.6.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/tty-cursor-0.6.1
        cp -r . $dest/gems/tty-cursor-0.6.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/tty-cursor-0.6.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "tty-cursor"
      s.version = "0.6.1"
      s.summary = "tty-cursor"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
