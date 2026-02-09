#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# virtus 1.0.4
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
  version = "1.0.4";
  src = builtins.path {
    path = ./source;
    name = "virtus-1.0.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/virtus-1.0.4
        cp -r . $dest/gems/virtus-1.0.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/virtus-1.0.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "virtus"
      s.version = "1.0.4"
      s.summary = "virtus"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
