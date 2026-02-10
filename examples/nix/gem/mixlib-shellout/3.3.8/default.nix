#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mixlib-shellout 3.3.8
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
  pname = "mixlib-shellout";
  version = "3.3.8";
  src = builtins.path {
    path = ./source;
    name = "mixlib-shellout-3.3.8-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/mixlib-shellout-3.3.8
        cp -r . $dest/gems/mixlib-shellout-3.3.8/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mixlib-shellout-3.3.8.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mixlib-shellout"
      s.version = "3.3.8"
      s.summary = "mixlib-shellout"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
