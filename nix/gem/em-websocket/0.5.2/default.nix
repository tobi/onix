#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# em-websocket 0.5.2
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
  pname = "em-websocket";
  version = "0.5.2";
  src = builtins.path {
    path = ./source;
    name = "em-websocket-0.5.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/em-websocket-0.5.2
        cp -r . $dest/gems/em-websocket-0.5.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/em-websocket-0.5.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "em-websocket"
      s.version = "0.5.2"
      s.summary = "em-websocket"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
