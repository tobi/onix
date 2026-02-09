#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# elasticsearch-model 8.0.0
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
  pname = "elasticsearch-model";
  version = "8.0.0";
  src = builtins.path {
    path = ./source;
    name = "elasticsearch-model-8.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/elasticsearch-model-8.0.0
        cp -r . $dest/gems/elasticsearch-model-8.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/elasticsearch-model-8.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "elasticsearch-model"
      s.version = "8.0.0"
      s.summary = "elasticsearch-model"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
