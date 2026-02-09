#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fog-google 1.29.1
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
  pname = "fog-google";
  version = "1.29.1";
  src = builtins.path {
    path = ./source;
    name = "fog-google-1.29.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fog-google-1.29.1
        cp -r . $dest/gems/fog-google-1.29.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fog-google-1.29.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fog-google"
      s.version = "1.29.1"
      s.summary = "fog-google"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
