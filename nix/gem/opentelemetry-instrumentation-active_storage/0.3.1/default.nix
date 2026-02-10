#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-instrumentation-active_storage 0.3.1
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
  pname = "opentelemetry-instrumentation-active_storage";
  version = "0.3.1";
  src = builtins.path {
    path = ./source;
    name = "opentelemetry-instrumentation-active_storage-0.3.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/opentelemetry-instrumentation-active_storage-0.3.1
        cp -r . $dest/gems/opentelemetry-instrumentation-active_storage-0.3.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/opentelemetry-instrumentation-active_storage-0.3.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "opentelemetry-instrumentation-active_storage"
      s.version = "0.3.1"
      s.summary = "opentelemetry-instrumentation-active_storage"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
