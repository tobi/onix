#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# celluloid 0.17.3
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
  pname = "celluloid";
  version = "0.17.3";
  src = builtins.path {
    path = ./source;
    name = "celluloid-0.17.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/celluloid-0.17.3
        cp -r . $dest/gems/celluloid-0.17.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/celluloid-0.17.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "celluloid"
      s.version = "0.17.3"
      s.summary = "celluloid"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
