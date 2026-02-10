#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# state_machines-activerecord 0.31.0
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
  pname = "state_machines-activerecord";
  version = "0.31.0";
  src = builtins.path {
    path = ./source;
    name = "state_machines-activerecord-0.31.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/state_machines-activerecord-0.31.0
        cp -r . $dest/gems/state_machines-activerecord-0.31.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/state_machines-activerecord-0.31.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "state_machines-activerecord"
      s.version = "0.31.0"
      s.summary = "state_machines-activerecord"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
