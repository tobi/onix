#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# websocket 1.2.10
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
  pname = "websocket";
  version = "1.2.10";
  src = builtins.path {
    path = ./source;
    name = "websocket-1.2.10-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/websocket-1.2.10
        cp -r . $dest/gems/websocket-1.2.10/
        mkdir -p $dest/specifications
        cat > $dest/specifications/websocket-1.2.10.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "websocket"
      s.version = "1.2.10"
      s.summary = "websocket"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
