#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# image_processing 1.12.2
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
  version = "1.12.2";
  src = builtins.path {
    path = ./source;
    name = "image_processing-1.12.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/image_processing-1.12.2
        cp -r . $dest/gems/image_processing-1.12.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/image_processing-1.12.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "image_processing"
      s.version = "1.12.2"
      s.summary = "image_processing"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
