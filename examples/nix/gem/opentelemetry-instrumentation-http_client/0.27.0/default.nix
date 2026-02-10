#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-http_client 0.27.0
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
  pname = "opentelemetry-instrumentation-http_client";
  version = "0.27.0";
  src = builtins.path {
    path = ./source;
    name = "opentelemetry-instrumentation-http_client-0.27.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/opentelemetry-instrumentation-http_client-0.27.0
        cp -r . $dest/gems/opentelemetry-instrumentation-http_client-0.27.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/opentelemetry-instrumentation-http_client-0.27.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "opentelemetry-instrumentation-http_client"
      s.version = "0.27.0"
      s.summary = "opentelemetry-instrumentation-http_client"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
