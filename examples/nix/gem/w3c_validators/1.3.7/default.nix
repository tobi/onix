#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# w3c_validators 1.3.7
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
  pname = "w3c_validators";
  version = "1.3.7";
  src = builtins.path {
    path = ./source;
    name = "w3c_validators-1.3.7-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/w3c_validators-1.3.7
        cp -r . $dest/gems/w3c_validators-1.3.7/
        mkdir -p $dest/specifications
        cat > $dest/specifications/w3c_validators-1.3.7.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "w3c_validators"
      s.version = "1.3.7"
      s.summary = "w3c_validators"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
