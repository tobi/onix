#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bullet 7.1.6
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
  pname = "bullet";
  version = "7.1.6";
  src = builtins.path {
    path = ./source;
    name = "bullet-7.1.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/bullet-7.1.6
        cp -r . $dest/gems/bullet-7.1.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/bullet-7.1.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "bullet"
      s.version = "7.1.6"
      s.summary = "bullet"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
