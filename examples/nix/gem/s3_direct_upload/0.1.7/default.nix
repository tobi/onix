#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# s3_direct_upload 0.1.7
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
  pname = "s3_direct_upload";
  version = "0.1.7";
  src = builtins.path {
    path = ./source;
    name = "s3_direct_upload-0.1.7-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/s3_direct_upload-0.1.7
        cp -r . $dest/gems/s3_direct_upload-0.1.7/
        mkdir -p $dest/specifications
        cat > $dest/specifications/s3_direct_upload-0.1.7.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "s3_direct_upload"
      s.version = "0.1.7"
      s.summary = "s3_direct_upload"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
