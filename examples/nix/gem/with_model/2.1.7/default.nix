#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# with_model 2.1.7
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
  pname = "with_model";
  version = "2.1.7";
  src = builtins.path {
    path = ./source;
    name = "with_model-2.1.7-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/with_model-2.1.7
        cp -r . $dest/gems/with_model-2.1.7/
        mkdir -p $dest/specifications
        cat > $dest/specifications/with_model-2.1.7.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "with_model"
      s.version = "2.1.7"
      s.summary = "with_model"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
