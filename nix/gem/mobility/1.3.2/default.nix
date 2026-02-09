#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mobility 1.3.2
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
  pname = "mobility";
  version = "1.3.2";
  src = builtins.path {
    path = ./source;
    name = "mobility-1.3.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/mobility-1.3.2
        cp -r . $dest/gems/mobility-1.3.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mobility-1.3.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mobility"
      s.version = "1.3.2"
      s.summary = "mobility"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
