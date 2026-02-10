#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# loofah 2.24.1
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
  pname = "loofah";
  version = "2.24.1";
  src = builtins.path {
    path = ./source;
    name = "loofah-2.24.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/loofah-2.24.1
        cp -r . $dest/gems/loofah-2.24.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/loofah-2.24.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "loofah"
      s.version = "2.24.1"
      s.summary = "loofah"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
