#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# virtus 2.0.0
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
  pname = "virtus";
  version = "2.0.0";
  src = builtins.path {
    path = ./source;
    name = "virtus-2.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/virtus-2.0.0
        cp -r . $dest/gems/virtus-2.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/virtus-2.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "virtus"
      s.version = "2.0.0"
      s.summary = "virtus"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
