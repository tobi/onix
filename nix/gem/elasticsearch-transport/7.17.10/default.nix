#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# elasticsearch-transport 7.17.10
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
  pname = "elasticsearch-transport";
  version = "7.17.10";
  src = builtins.path {
    path = ./source;
    name = "elasticsearch-transport-7.17.10-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/elasticsearch-transport-7.17.10
        cp -r . $dest/gems/elasticsearch-transport-7.17.10/
        mkdir -p $dest/specifications
        cat > $dest/specifications/elasticsearch-transport-7.17.10.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "elasticsearch-transport"
      s.version = "7.17.10"
      s.summary = "elasticsearch-transport"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
