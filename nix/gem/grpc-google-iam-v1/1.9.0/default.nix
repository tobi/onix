#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# grpc-google-iam-v1 1.9.0
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
  pname = "grpc-google-iam-v1";
  version = "1.9.0";
  src = builtins.path {
    path = ./source;
    name = "grpc-google-iam-v1-1.9.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/grpc-google-iam-v1-1.9.0
        cp -r . $dest/gems/grpc-google-iam-v1-1.9.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/grpc-google-iam-v1-1.9.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "grpc-google-iam-v1"
      s.version = "1.9.0"
      s.summary = "grpc-google-iam-v1"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
