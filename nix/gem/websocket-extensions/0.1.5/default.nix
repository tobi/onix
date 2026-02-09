#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# websocket-extensions 0.1.5
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "websocket-extensions";
  version = "0.1.5";
  src = builtins.path {
    path = ./source;
    name = "websocket-extensions-0.1.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/websocket-extensions-0.1.5
        cp -r . $dest/gems/websocket-extensions-0.1.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/websocket-extensions-0.1.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "websocket-extensions"
      s.version = "0.1.5"
      s.summary = "websocket-extensions"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
