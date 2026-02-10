#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# systemu 2.6.4
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
  pname = "systemu";
  version = "2.6.4";
  src = builtins.path {
    path = ./source;
    name = "systemu-2.6.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/systemu-2.6.4
        cp -r . $dest/gems/systemu-2.6.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/systemu-2.6.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "systemu"
      s.version = "2.6.4"
      s.summary = "systemu"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
