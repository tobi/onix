#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# android_key_attestation 0.3.0
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
  pname = "android_key_attestation";
  version = "0.3.0";
  src = builtins.path {
    path = ./source;
    name = "android_key_attestation-0.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/android_key_attestation-0.3.0
        cp -r . $dest/gems/android_key_attestation-0.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/android_key_attestation-0.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "android_key_attestation"
      s.version = "0.3.0"
      s.summary = "android_key_attestation"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
