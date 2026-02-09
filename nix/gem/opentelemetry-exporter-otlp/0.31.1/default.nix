#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-exporter-otlp 0.31.1
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
  pname = "opentelemetry-exporter-otlp";
  version = "0.31.1";
  src = builtins.path {
    path = ./source;
    name = "opentelemetry-exporter-otlp-0.31.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/opentelemetry-exporter-otlp-0.31.1
        cp -r . $dest/gems/opentelemetry-exporter-otlp-0.31.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/opentelemetry-exporter-otlp-0.31.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "opentelemetry-exporter-otlp"
      s.version = "0.31.1"
      s.summary = "opentelemetry-exporter-otlp"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
