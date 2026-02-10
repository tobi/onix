#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-redis 0.28.0
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
  pname = "opentelemetry-instrumentation-redis";
  version = "0.28.0";
  src = builtins.path {
    path = ./source;
    name = "opentelemetry-instrumentation-redis-0.28.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/opentelemetry-instrumentation-redis-0.28.0
        cp -r . $dest/gems/opentelemetry-instrumentation-redis-0.28.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/opentelemetry-instrumentation-redis-0.28.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "opentelemetry-instrumentation-redis"
      s.version = "0.28.0"
      s.summary = "opentelemetry-instrumentation-redis"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
