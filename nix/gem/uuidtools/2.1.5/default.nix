#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# uuidtools 2.1.5
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
  pname = "uuidtools";
  version = "2.1.5";
  src = builtins.path {
    path = ./source;
    name = "uuidtools-2.1.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/uuidtools-2.1.5
        cp -r . $dest/gems/uuidtools-2.1.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/uuidtools-2.1.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "uuidtools"
      s.version = "2.1.5"
      s.summary = "uuidtools"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
