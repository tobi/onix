#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# xml-simple 1.1.9
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
  pname = "xml-simple";
  version = "1.1.9";
  src = builtins.path {
    path = ./source;
    name = "xml-simple-1.1.9-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/xml-simple-1.1.9
        cp -r . $dest/gems/xml-simple-1.1.9/
        mkdir -p $dest/specifications
        cat > $dest/specifications/xml-simple-1.1.9.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "xml-simple"
      s.version = "1.1.9"
      s.summary = "xml-simple"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
