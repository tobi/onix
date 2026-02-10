#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ecma-re-validator 0.4.0
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
  pname = "ecma-re-validator";
  version = "0.4.0";
  src = builtins.path {
    path = ./source;
    name = "ecma-re-validator-0.4.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ecma-re-validator-0.4.0
        cp -r . $dest/gems/ecma-re-validator-0.4.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ecma-re-validator-0.4.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ecma-re-validator"
      s.version = "0.4.0"
      s.summary = "ecma-re-validator"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
