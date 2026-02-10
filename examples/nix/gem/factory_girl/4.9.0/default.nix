#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# factory_girl 4.9.0
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
  pname = "factory_girl";
  version = "4.9.0";
  src = builtins.path {
    path = ./source;
    name = "factory_girl-4.9.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/factory_girl-4.9.0
        cp -r . $dest/gems/factory_girl-4.9.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/factory_girl-4.9.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "factory_girl"
      s.version = "4.9.0"
      s.summary = "factory_girl"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
