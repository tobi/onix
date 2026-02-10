#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# active_model_serializers 0.8.4
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
  pname = "active_model_serializers";
  version = "0.8.4";
  src = builtins.path {
    path = ./source;
    name = "active_model_serializers-0.8.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/active_model_serializers-0.8.4
        cp -r . $dest/gems/active_model_serializers-0.8.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/active_model_serializers-0.8.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "active_model_serializers"
      s.version = "0.8.4"
      s.summary = "active_model_serializers"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
