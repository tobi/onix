#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# celluloid-pool 0.20.0
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
  pname = "celluloid-pool";
  version = "0.20.0";
  src = builtins.path {
    path = ./source;
    name = "celluloid-pool-0.20.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/celluloid-pool-0.20.0
        cp -r . $dest/gems/celluloid-pool-0.20.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/celluloid-pool-0.20.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "celluloid-pool"
      s.version = "0.20.0"
      s.summary = "celluloid-pool"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
