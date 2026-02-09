#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rqrcode_core 2.1.0
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
  pname = "rqrcode_core";
  version = "2.1.0";
  src = builtins.path {
    path = ./source;
    name = "rqrcode_core-2.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rqrcode_core-2.1.0
        cp -r . $dest/gems/rqrcode_core-2.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rqrcode_core-2.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rqrcode_core"
      s.version = "2.1.0"
      s.summary = "rqrcode_core"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
