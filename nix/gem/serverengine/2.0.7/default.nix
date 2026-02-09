#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# serverengine 2.0.7
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
  pname = "serverengine";
  version = "2.0.7";
  src = builtins.path {
    path = ./source;
    name = "serverengine-2.0.7-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/serverengine-2.0.7
        cp -r . $dest/gems/serverengine-2.0.7/
        mkdir -p $dest/specifications
        cat > $dest/specifications/serverengine-2.0.7.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "serverengine"
      s.version = "2.0.7"
      s.summary = "serverengine"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
