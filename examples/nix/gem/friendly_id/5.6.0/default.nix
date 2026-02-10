#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# friendly_id 5.6.0
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
  pname = "friendly_id";
  version = "5.6.0";
  src = builtins.path {
    path = ./source;
    name = "friendly_id-5.6.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/friendly_id-5.6.0
        cp -r . $dest/gems/friendly_id-5.6.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/friendly_id-5.6.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "friendly_id"
      s.version = "5.6.0"
      s.summary = "friendly_id"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
