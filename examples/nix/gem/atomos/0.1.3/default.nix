#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# atomos 0.1.3
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
  pname = "atomos";
  version = "0.1.3";
  src = builtins.path {
    path = ./source;
    name = "atomos-0.1.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/atomos-0.1.3
        cp -r . $dest/gems/atomos-0.1.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/atomos-0.1.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "atomos"
      s.version = "0.1.3"
      s.summary = "atomos"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
