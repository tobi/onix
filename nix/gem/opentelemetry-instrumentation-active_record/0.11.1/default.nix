#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-active_record 0.11.1
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
  pname = "opentelemetry-instrumentation-active_record";
  version = "0.11.1";
  src = builtins.path {
    path = ./source;
    name = "opentelemetry-instrumentation-active_record-0.11.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/opentelemetry-instrumentation-active_record-0.11.1
        cp -r . $dest/gems/opentelemetry-instrumentation-active_record-0.11.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/opentelemetry-instrumentation-active_record-0.11.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "opentelemetry-instrumentation-active_record"
      s.version = "0.11.1"
      s.summary = "opentelemetry-instrumentation-active_record"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
