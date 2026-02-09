#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# phonelib 0.10.15
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
  pname = "phonelib";
  version = "0.10.15";
  src = builtins.path {
    path = ./source;
    name = "phonelib-0.10.15-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/phonelib-0.10.15
        cp -r . $dest/gems/phonelib-0.10.15/
        mkdir -p $dest/specifications
        cat > $dest/specifications/phonelib-0.10.15.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "phonelib"
      s.version = "0.10.15"
      s.summary = "phonelib"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
