#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# grape-entity 0.10.2
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
  pname = "grape-entity";
  version = "0.10.2";
  src = builtins.path {
    path = ./source;
    name = "grape-entity-0.10.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/grape-entity-0.10.2
        cp -r . $dest/gems/grape-entity-0.10.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/grape-entity-0.10.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "grape-entity"
      s.version = "0.10.2"
      s.summary = "grape-entity"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
