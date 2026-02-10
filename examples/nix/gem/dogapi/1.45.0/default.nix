#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dogapi 1.45.0
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
  pname = "dogapi";
  version = "1.45.0";
  src = builtins.path {
    path = ./source;
    name = "dogapi-1.45.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/dogapi-1.45.0
        cp -r . $dest/gems/dogapi-1.45.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/dogapi-1.45.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "dogapi"
      s.version = "1.45.0"
      s.summary = "dogapi"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
