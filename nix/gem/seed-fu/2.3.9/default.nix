#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# seed-fu 2.3.9
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
  pname = "seed-fu";
  version = "2.3.9";
  src = builtins.path {
    path = ./source;
    name = "seed-fu-2.3.9-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/seed-fu-2.3.9
        cp -r . $dest/gems/seed-fu-2.3.9/
        mkdir -p $dest/specifications
        cat > $dest/specifications/seed-fu-2.3.9.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "seed-fu"
      s.version = "2.3.9"
      s.summary = "seed-fu"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
