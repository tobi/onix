#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tty-color 0.5.1
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
  pname = "tty-color";
  version = "0.5.1";
  src = builtins.path {
    path = ./source;
    name = "tty-color-0.5.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/tty-color-0.5.1
        cp -r . $dest/gems/tty-color-0.5.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/tty-color-0.5.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "tty-color"
      s.version = "0.5.1"
      s.summary = "tty-color"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
