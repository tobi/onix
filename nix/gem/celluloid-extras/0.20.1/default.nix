#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# celluloid-extras 0.20.1
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
  pname = "celluloid-extras";
  version = "0.20.1";
  src = builtins.path {
    path = ./source;
    name = "celluloid-extras-0.20.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/celluloid-extras-0.20.1
        cp -r . $dest/gems/celluloid-extras-0.20.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/celluloid-extras-0.20.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "celluloid-extras"
      s.version = "0.20.1"
      s.summary = "celluloid-extras"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
