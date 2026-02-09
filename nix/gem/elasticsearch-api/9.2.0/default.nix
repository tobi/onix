#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# elasticsearch-api 9.2.0
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
  pname = "elasticsearch-api";
  version = "9.2.0";
  src = builtins.path {
    path = ./source;
    name = "elasticsearch-api-9.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/elasticsearch-api-9.2.0
        cp -r . $dest/gems/elasticsearch-api-9.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/elasticsearch-api-9.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "elasticsearch-api"
      s.version = "9.2.0"
      s.summary = "elasticsearch-api"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
