#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ransack 4.3.0
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
  pname = "ransack";
  version = "4.3.0";
  src = builtins.path {
    path = ./source;
    name = "ransack-4.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ransack-4.3.0
        cp -r . $dest/gems/ransack-4.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ransack-4.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ransack"
      s.version = "4.3.0"
      s.summary = "ransack"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
