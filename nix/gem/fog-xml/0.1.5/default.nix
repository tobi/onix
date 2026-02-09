#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fog-xml 0.1.5
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
  pname = "fog-xml";
  version = "0.1.5";
  src = builtins.path {
    path = ./source;
    name = "fog-xml-0.1.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fog-xml-0.1.5
        cp -r . $dest/gems/fog-xml-0.1.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fog-xml-0.1.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fog-xml"
      s.version = "0.1.5"
      s.summary = "fog-xml"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
