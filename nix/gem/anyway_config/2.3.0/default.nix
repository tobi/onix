#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# anyway_config 2.3.0
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
  pname = "anyway_config";
  version = "2.3.0";
  src = builtins.path {
    path = ./source;
    name = "anyway_config-2.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/anyway_config-2.3.0
        cp -r . $dest/gems/anyway_config-2.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/anyway_config-2.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "anyway_config"
      s.version = "2.3.0"
      s.summary = "anyway_config"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
