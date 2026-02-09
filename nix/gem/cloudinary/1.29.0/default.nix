#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cloudinary 1.29.0
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
  pname = "cloudinary";
  version = "1.29.0";
  src = builtins.path {
    path = ./source;
    name = "cloudinary-1.29.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/cloudinary-1.29.0
        cp -r . $dest/gems/cloudinary-1.29.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/cloudinary-1.29.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "cloudinary"
      s.version = "1.29.0"
      s.summary = "cloudinary"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
