#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# html-pipeline 3.2.2
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
  pname = "html-pipeline";
  version = "3.2.2";
  src = builtins.path {
    path = ./source;
    name = "html-pipeline-3.2.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/html-pipeline-3.2.2
        cp -r . $dest/gems/html-pipeline-3.2.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/html-pipeline-3.2.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "html-pipeline"
      s.version = "3.2.2"
      s.summary = "html-pipeline"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
