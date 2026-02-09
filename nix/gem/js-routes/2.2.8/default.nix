#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# js-routes 2.2.8
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
  pname = "js-routes";
  version = "2.2.8";
  src = builtins.path {
    path = ./source;
    name = "js-routes-2.2.8-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/js-routes-2.2.8
        cp -r . $dest/gems/js-routes-2.2.8/
        mkdir -p $dest/specifications
        cat > $dest/specifications/js-routes-2.2.8.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "js-routes"
      s.version = "2.2.8"
      s.summary = "js-routes"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
