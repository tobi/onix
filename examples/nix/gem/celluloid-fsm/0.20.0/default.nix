#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# celluloid-fsm 0.20.0
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
  pname = "celluloid-fsm";
  version = "0.20.0";
  src = builtins.path {
    path = ./source;
    name = "celluloid-fsm-0.20.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/celluloid-fsm-0.20.0
        cp -r . $dest/gems/celluloid-fsm-0.20.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/celluloid-fsm-0.20.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "celluloid-fsm"
      s.version = "0.20.0"
      s.summary = "celluloid-fsm"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
