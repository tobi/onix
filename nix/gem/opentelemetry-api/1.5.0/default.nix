#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-api 1.5.0
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
  pname = "opentelemetry-api";
  version = "1.5.0";
  src = builtins.path {
    path = ./source;
    name = "opentelemetry-api-1.5.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/opentelemetry-api-1.5.0
        cp -r . $dest/gems/opentelemetry-api-1.5.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/opentelemetry-api-1.5.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "opentelemetry-api"
      s.version = "1.5.0"
      s.summary = "opentelemetry-api"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
