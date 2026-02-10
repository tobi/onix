#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-cloud-storage 1.58.0
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
  pname = "google-cloud-storage";
  version = "1.58.0";
  src = builtins.path {
    path = ./source;
    name = "google-cloud-storage-1.58.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/google-cloud-storage-1.58.0
        cp -r . $dest/gems/google-cloud-storage-1.58.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/google-cloud-storage-1.58.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "google-cloud-storage"
      s.version = "1.58.0"
      s.summary = "google-cloud-storage"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
