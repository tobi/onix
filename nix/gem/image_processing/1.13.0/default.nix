#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# image_processing 1.13.0
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
  pname = "image_processing";
  version = "1.13.0";
  src = builtins.path {
    path = ./source;
    name = "image_processing-1.13.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/image_processing-1.13.0
        cp -r . $dest/gems/image_processing-1.13.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/image_processing-1.13.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "image_processing"
      s.version = "1.13.0"
      s.summary = "image_processing"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
