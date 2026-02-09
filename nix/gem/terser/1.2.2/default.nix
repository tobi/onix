#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# terser 1.2.2
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
  pname = "terser";
  version = "1.2.2";
  src = builtins.path {
    path = ./source;
    name = "terser-1.2.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/terser-1.2.2
        cp -r . $dest/gems/terser-1.2.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/terser-1.2.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "terser"
      s.version = "1.2.2"
      s.summary = "terser"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
