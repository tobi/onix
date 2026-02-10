#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mixlib-cli 2.1.8
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
  pname = "mixlib-cli";
  version = "2.1.8";
  src = builtins.path {
    path = ./source;
    name = "mixlib-cli-2.1.8-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/mixlib-cli-2.1.8
        cp -r . $dest/gems/mixlib-cli-2.1.8/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mixlib-cli-2.1.8.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mixlib-cli"
      s.version = "2.1.8"
      s.summary = "mixlib-cli"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
