#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rainbow 3.0.0
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
  pname = "rainbow";
  version = "3.0.0";
  src = builtins.path {
    path = ./source;
    name = "rainbow-3.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rainbow-3.0.0
        cp -r . $dest/gems/rainbow-3.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rainbow-3.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rainbow"
      s.version = "3.0.0"
      s.summary = "rainbow"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
