#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# activemodel 7.0.8.7
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
  pname = "activemodel";
  version = "7.0.8.7";
  src = builtins.path {
    path = ./source;
    name = "activemodel-7.0.8.7-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/activemodel-7.0.8.7
        cp -r . $dest/gems/activemodel-7.0.8.7/
        mkdir -p $dest/specifications
        cat > $dest/specifications/activemodel-7.0.8.7.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "activemodel"
      s.version = "7.0.8.7"
      s.summary = "activemodel"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
