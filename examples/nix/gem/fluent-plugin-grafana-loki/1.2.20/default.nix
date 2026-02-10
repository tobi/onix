#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fluent-plugin-grafana-loki 1.2.20
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
  version = "1.2.20";
  src = builtins.path {
    path = ./source;
    name = "fluent-plugin-grafana-loki-1.2.20-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fluent-plugin-grafana-loki-1.2.20
        cp -r . $dest/gems/fluent-plugin-grafana-loki-1.2.20/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fluent-plugin-grafana-loki-1.2.20.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fluent-plugin-grafana-loki"
      s.version = "1.2.20"
      s.summary = "fluent-plugin-grafana-loki"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
