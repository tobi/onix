#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# iso-639 0.3.8
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
  pname = "iso-639";
  version = "0.3.8";
  src = builtins.path {
    path = ./source;
    name = "iso-639-0.3.8-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/iso-639-0.3.8
        cp -r . $dest/gems/iso-639-0.3.8/
        mkdir -p $dest/specifications
        cat > $dest/specifications/iso-639-0.3.8.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "iso-639"
      s.version = "0.3.8"
      s.summary = "iso-639"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
