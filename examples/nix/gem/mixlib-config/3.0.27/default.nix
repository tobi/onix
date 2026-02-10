#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mixlib-config 3.0.27
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
  pname = "mixlib-config";
  version = "3.0.27";
  src = builtins.path {
    path = ./source;
    name = "mixlib-config-3.0.27-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/mixlib-config-3.0.27
        cp -r . $dest/gems/mixlib-config-3.0.27/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mixlib-config-3.0.27.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mixlib-config"
      s.version = "3.0.27"
      s.summary = "mixlib-config"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
