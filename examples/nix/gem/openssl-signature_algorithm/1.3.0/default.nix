#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# openssl-signature_algorithm 1.3.0
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
  pname = "openssl-signature_algorithm";
  version = "1.3.0";
  src = builtins.path {
    path = ./source;
    name = "openssl-signature_algorithm-1.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/openssl-signature_algorithm-1.3.0
        cp -r . $dest/gems/openssl-signature_algorithm-1.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/openssl-signature_algorithm-1.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "openssl-signature_algorithm"
      s.version = "1.3.0"
      s.summary = "openssl-signature_algorithm"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
