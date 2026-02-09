#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# zip_kit 6.3.4
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
  pname = "zip_kit";
  version = "6.3.4";
  src = builtins.path {
    path = ./source;
    name = "zip_kit-6.3.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/zip_kit-6.3.4
        cp -r . $dest/gems/zip_kit-6.3.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/zip_kit-6.3.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "zip_kit"
      s.version = "6.3.4"
      s.summary = "zip_kit"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
