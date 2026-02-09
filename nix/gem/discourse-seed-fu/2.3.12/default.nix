#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# discourse-seed-fu 2.3.12
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
  pname = "discourse-seed-fu";
  version = "2.3.12";
  src = builtins.path {
    path = ./source;
    name = "discourse-seed-fu-2.3.12-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/discourse-seed-fu-2.3.12
        cp -r . $dest/gems/discourse-seed-fu-2.3.12/
        mkdir -p $dest/specifications
        cat > $dest/specifications/discourse-seed-fu-2.3.12.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "discourse-seed-fu"
      s.version = "2.3.12"
      s.summary = "discourse-seed-fu"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
