#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-helpers-sql-processor 0.4.0
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
  pname = "opentelemetry-helpers-sql-processor";
  version = "0.4.0";
  src = builtins.path {
    path = ./source;
    name = "opentelemetry-helpers-sql-processor-0.4.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/opentelemetry-helpers-sql-processor-0.4.0
        cp -r . $dest/gems/opentelemetry-helpers-sql-processor-0.4.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/opentelemetry-helpers-sql-processor-0.4.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "opentelemetry-helpers-sql-processor"
      s.version = "0.4.0"
      s.summary = "opentelemetry-helpers-sql-processor"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
