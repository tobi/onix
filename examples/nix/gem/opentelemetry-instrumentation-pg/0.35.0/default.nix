#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-pg 0.35.0
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
  pname = "opentelemetry-instrumentation-pg";
  version = "0.35.0";
  src = builtins.path {
    path = ./source;
    name = "opentelemetry-instrumentation-pg-0.35.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/opentelemetry-instrumentation-pg-0.35.0
        cp -r . $dest/gems/opentelemetry-instrumentation-pg-0.35.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/opentelemetry-instrumentation-pg-0.35.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "opentelemetry-instrumentation-pg"
      s.version = "0.35.0"
      s.summary = "opentelemetry-instrumentation-pg"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
