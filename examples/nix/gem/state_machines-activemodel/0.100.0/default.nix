#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# state_machines-activemodel 0.100.0
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
  pname = "state_machines-activemodel";
  version = "0.100.0";
  src = builtins.path {
    path = ./source;
    name = "state_machines-activemodel-0.100.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/state_machines-activemodel-0.100.0
        cp -r . $dest/gems/state_machines-activemodel-0.100.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/state_machines-activemodel-0.100.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "state_machines-activemodel"
      s.version = "0.100.0"
      s.summary = "state_machines-activemodel"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
