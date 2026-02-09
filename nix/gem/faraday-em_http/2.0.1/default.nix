#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-em_http 2.0.1
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
  pname = "faraday-em_http";
  version = "2.0.1";
  src = builtins.path {
    path = ./source;
    name = "faraday-em_http-2.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/faraday-em_http-2.0.1
        cp -r . $dest/gems/faraday-em_http-2.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/faraday-em_http-2.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "faraday-em_http"
      s.version = "2.0.1"
      s.summary = "faraday-em_http"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
