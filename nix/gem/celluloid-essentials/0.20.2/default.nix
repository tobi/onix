#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# celluloid-essentials 0.20.2
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
  pname = "celluloid-essentials";
  version = "0.20.2";
  src = builtins.path {
    path = ./source;
    name = "celluloid-essentials-0.20.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/celluloid-essentials-0.20.2
        cp -r . $dest/gems/celluloid-essentials-0.20.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/celluloid-essentials-0.20.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "celluloid-essentials"
      s.version = "0.20.2"
      s.summary = "celluloid-essentials"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
