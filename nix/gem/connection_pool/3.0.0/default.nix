#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# connection_pool 3.0.0
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
  pname = "connection_pool";
  version = "3.0.0";
  src = builtins.path {
    path = ./source;
    name = "connection_pool-3.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/connection_pool-3.0.0
        cp -r . $dest/gems/connection_pool-3.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/connection_pool-3.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "connection_pool"
      s.version = "3.0.0"
      s.summary = "connection_pool"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
