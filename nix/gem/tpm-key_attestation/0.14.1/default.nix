#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tpm-key_attestation 0.14.1
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
  pname = "tpm-key_attestation";
  version = "0.14.1";
  src = builtins.path {
    path = ./source;
    name = "tpm-key_attestation-0.14.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/tpm-key_attestation-0.14.1
        cp -r . $dest/gems/tpm-key_attestation-0.14.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/tpm-key_attestation-0.14.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "tpm-key_attestation"
      s.version = "0.14.1"
      s.summary = "tpm-key_attestation"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
