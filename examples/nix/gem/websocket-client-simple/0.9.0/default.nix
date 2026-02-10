#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# websocket-client-simple 0.9.0
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
  pname = "websocket-client-simple";
  version = "0.9.0";
  src = builtins.path {
    path = ./source;
    name = "websocket-client-simple-0.9.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/websocket-client-simple-0.9.0
        cp -r . $dest/gems/websocket-client-simple-0.9.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/websocket-client-simple-0.9.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "websocket-client-simple"
      s.version = "0.9.0"
      s.summary = "websocket-client-simple"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
