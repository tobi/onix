#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-semantic_conventions 1.36.0
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
  pname = "opentelemetry-semantic_conventions";
  version = "1.36.0";
  src = builtins.path {
    path = ./source;
    name = "opentelemetry-semantic_conventions-1.36.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/opentelemetry-semantic_conventions-1.36.0
        cp -r . $dest/gems/opentelemetry-semantic_conventions-1.36.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/opentelemetry-semantic_conventions-1.36.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "opentelemetry-semantic_conventions"
      s.version = "1.36.0"
      s.summary = "opentelemetry-semantic_conventions"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
