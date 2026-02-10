#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# websocket-extensions 0.1.3
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
  version = "0.1.3";
  src = builtins.path {
    path = ./source;
    name = "websocket-extensions-0.1.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/websocket-extensions-0.1.3
        cp -r . $dest/gems/websocket-extensions-0.1.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/websocket-extensions-0.1.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "websocket-extensions"
      s.version = "0.1.3"
      s.summary = "websocket-extensions"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
