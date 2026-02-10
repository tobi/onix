#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack-cors 2.0.0
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
  pname = "rack-cors";
  version = "2.0.0";
  src = builtins.path {
    path = ./source;
    name = "rack-cors-2.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rack-cors-2.0.0
        cp -r . $dest/gems/rack-cors-2.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rack-cors-2.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rack-cors"
      s.version = "2.0.0"
      s.summary = "rack-cors"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
