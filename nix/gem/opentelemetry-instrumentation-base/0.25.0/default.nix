#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-base 0.25.0
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
  pname = "opentelemetry-instrumentation-base";
  version = "0.25.0";
  src = builtins.path {
    path = ./source;
    name = "opentelemetry-instrumentation-base-0.25.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/opentelemetry-instrumentation-base-0.25.0
        cp -r . $dest/gems/opentelemetry-instrumentation-base-0.25.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/opentelemetry-instrumentation-base-0.25.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "opentelemetry-instrumentation-base"
      s.version = "0.25.0"
      s.summary = "opentelemetry-instrumentation-base"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
