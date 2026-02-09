#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# marginalia 1.11.0
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
  pname = "marginalia";
  version = "1.11.0";
  src = builtins.path {
    path = ./source;
    name = "marginalia-1.11.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/marginalia-1.11.0
        cp -r . $dest/gems/marginalia-1.11.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/marginalia-1.11.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "marginalia"
      s.version = "1.11.0"
      s.summary = "marginalia"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
