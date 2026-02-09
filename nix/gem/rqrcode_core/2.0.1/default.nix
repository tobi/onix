#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rqrcode_core 2.0.1
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
  pname = "rqrcode_core";
  version = "2.0.1";
  src = builtins.path {
    path = ./source;
    name = "rqrcode_core-2.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/rqrcode_core-2.0.1
        cp -r . $dest/gems/rqrcode_core-2.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rqrcode_core-2.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rqrcode_core"
      s.version = "2.0.1"
      s.summary = "rqrcode_core"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
