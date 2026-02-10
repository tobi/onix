#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# vault 0.20.0
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
  pname = "vault";
  version = "0.20.0";
  src = builtins.path {
    path = ./source;
    name = "vault-0.20.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/vault-0.20.0
        cp -r . $dest/gems/vault-0.20.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/vault-0.20.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "vault"
      s.version = "0.20.0"
      s.summary = "vault"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
