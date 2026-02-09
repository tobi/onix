#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cuprite 0.15
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
  pname = "cuprite";
  version = "0.15";
  src = builtins.path {
    path = ./source;
    name = "cuprite-0.15-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/cuprite-0.15
        cp -r . $dest/gems/cuprite-0.15/
        mkdir -p $dest/specifications
        cat > $dest/specifications/cuprite-0.15.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "cuprite"
      s.version = "0.15"
      s.summary = "cuprite"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
