#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tty-screen 0.8.1
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
  pname = "tty-screen";
  version = "0.8.1";
  src = builtins.path {
    path = ./source;
    name = "tty-screen-0.8.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/tty-screen-0.8.1
        cp -r . $dest/gems/tty-screen-0.8.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/tty-screen-0.8.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "tty-screen"
      s.version = "0.8.1"
      s.summary = "tty-screen"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
