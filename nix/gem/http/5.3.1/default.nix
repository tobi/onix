#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# http 5.3.1
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
  pname = "http";
  version = "5.3.1";
  src = builtins.path {
    path = ./source;
    name = "http-5.3.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/http-5.3.1
        cp -r . $dest/gems/http-5.3.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/http-5.3.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "http"
      s.version = "5.3.1"
      s.summary = "http"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
