#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# state_machines 0.100.4
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
  pname = "state_machines";
  version = "0.100.4";
  src = builtins.path {
    path = ./source;
    name = "state_machines-0.100.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/state_machines-0.100.4
        cp -r . $dest/gems/state_machines-0.100.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/state_machines-0.100.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "state_machines"
      s.version = "0.100.4"
      s.summary = "state_machines"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
