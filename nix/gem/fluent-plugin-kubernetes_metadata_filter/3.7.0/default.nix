#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fluent-plugin-kubernetes_metadata_filter 3.7.0
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
  pname = "fluent-plugin-kubernetes_metadata_filter";
  version = "3.7.0";
  src = builtins.path {
    path = ./source;
    name = "fluent-plugin-kubernetes_metadata_filter-3.7.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fluent-plugin-kubernetes_metadata_filter-3.7.0
        cp -r . $dest/gems/fluent-plugin-kubernetes_metadata_filter-3.7.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fluent-plugin-kubernetes_metadata_filter-3.7.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fluent-plugin-kubernetes_metadata_filter"
      s.version = "3.7.0"
      s.summary = "fluent-plugin-kubernetes_metadata_filter"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
