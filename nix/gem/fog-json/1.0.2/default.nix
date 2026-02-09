#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fog-json 1.0.2
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
  pname = "fog-json";
  version = "1.0.2";
  src = builtins.path {
    path = ./source;
    name = "fog-json-1.0.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fog-json-1.0.2
        cp -r . $dest/gems/fog-json-1.0.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fog-json-1.0.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fog-json"
      s.version = "1.0.2"
      s.summary = "fog-json"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
