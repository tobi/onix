#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# websocket-extensions 0.1.4
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
  pname = "websocket-extensions";
  version = "0.1.4";
  src = builtins.path {
    path = ./source;
    name = "websocket-extensions-0.1.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/websocket-extensions-0.1.4
        cp -r . $dest/gems/websocket-extensions-0.1.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/websocket-extensions-0.1.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "websocket-extensions"
      s.version = "0.1.4"
      s.summary = "websocket-extensions"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
