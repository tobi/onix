#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# elasticsearch-dsl 0.1.10
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
  pname = "elasticsearch-dsl";
  version = "0.1.10";
  src = builtins.path {
    path = ./source;
    name = "elasticsearch-dsl-0.1.10-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/elasticsearch-dsl-0.1.10
        cp -r . $dest/gems/elasticsearch-dsl-0.1.10/
        mkdir -p $dest/specifications
        cat > $dest/specifications/elasticsearch-dsl-0.1.10.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "elasticsearch-dsl"
      s.version = "0.1.10"
      s.summary = "elasticsearch-dsl"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
