#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# powerpack 0.1.2
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
  pname = "powerpack";
  version = "0.1.2";
  src = builtins.path {
    path = ./source;
    name = "powerpack-0.1.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/powerpack-0.1.2
        cp -r . $dest/gems/powerpack-0.1.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/powerpack-0.1.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "powerpack"
      s.version = "0.1.2"
      s.summary = "powerpack"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
