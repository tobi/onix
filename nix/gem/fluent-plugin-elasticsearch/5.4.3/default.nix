#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fluent-plugin-elasticsearch 5.4.3
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
  pname = "fluent-plugin-elasticsearch";
  version = "5.4.3";
  src = builtins.path {
    path = ./source;
    name = "fluent-plugin-elasticsearch-5.4.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fluent-plugin-elasticsearch-5.4.3
        cp -r . $dest/gems/fluent-plugin-elasticsearch-5.4.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fluent-plugin-elasticsearch-5.4.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fluent-plugin-elasticsearch"
      s.version = "5.4.3"
      s.summary = "fluent-plugin-elasticsearch"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
