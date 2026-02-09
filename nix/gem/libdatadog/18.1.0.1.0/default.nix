#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# libdatadog 18.1.0.1.0
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
  pname = "libdatadog";
  version = "18.1.0.1.0";
  src = builtins.path {
    path = ./source;
    name = "libdatadog-18.1.0.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/libdatadog-18.1.0.1.0
        cp -r . $dest/gems/libdatadog-18.1.0.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/libdatadog-18.1.0.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "libdatadog"
      s.version = "18.1.0.1.0"
      s.summary = "libdatadog"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
