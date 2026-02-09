#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fluent-plugin-grafana-loki 1.2.19
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
  pname = "fluent-plugin-grafana-loki";
  version = "1.2.19";
  src = builtins.path {
    path = ./source;
    name = "fluent-plugin-grafana-loki-1.2.19-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fluent-plugin-grafana-loki-1.2.19
        cp -r . $dest/gems/fluent-plugin-grafana-loki-1.2.19/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fluent-plugin-grafana-loki-1.2.19.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fluent-plugin-grafana-loki"
      s.version = "1.2.19"
      s.summary = "fluent-plugin-grafana-loki"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
