#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# elasticsearch-api 7.17.11
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
  version = "7.17.11";
  src = builtins.path {
    path = ./source;
    name = "elasticsearch-api-7.17.11-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/elasticsearch-api-7.17.11
        cp -r . $dest/gems/elasticsearch-api-7.17.11/
        mkdir -p $dest/specifications
        cat > $dest/specifications/elasticsearch-api-7.17.11.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "elasticsearch-api"
      s.version = "7.17.11"
      s.summary = "elasticsearch-api"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
