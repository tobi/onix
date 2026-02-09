#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# airbrake 13.0.3
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
  pname = "airbrake";
  version = "13.0.3";
  src = builtins.path {
    path = ./source;
    name = "airbrake-13.0.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/airbrake-13.0.3
        cp -r . $dest/gems/airbrake-13.0.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/airbrake-13.0.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "airbrake"
      s.version = "13.0.3"
      s.summary = "airbrake"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
