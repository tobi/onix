#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-sidekiq 0.28.1
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
  pname = "opentelemetry-instrumentation-sidekiq";
  version = "0.28.1";
  src = builtins.path {
    path = ./source;
    name = "opentelemetry-instrumentation-sidekiq-0.28.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/opentelemetry-instrumentation-sidekiq-0.28.1
        cp -r . $dest/gems/opentelemetry-instrumentation-sidekiq-0.28.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/opentelemetry-instrumentation-sidekiq-0.28.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "opentelemetry-instrumentation-sidekiq"
      s.version = "0.28.1"
      s.summary = "opentelemetry-instrumentation-sidekiq"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
