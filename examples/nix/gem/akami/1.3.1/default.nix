#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# akami 1.3.1
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
  pname = "akami";
  version = "1.3.1";
  src = builtins.path {
    path = ./source;
    name = "akami-1.3.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/akami-1.3.1
        cp -r . $dest/gems/akami-1.3.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/akami-1.3.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "akami"
      s.version = "1.3.1"
      s.summary = "akami"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
