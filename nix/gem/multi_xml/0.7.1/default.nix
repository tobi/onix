#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# multi_xml 0.7.1
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
  pname = "multi_xml";
  version = "0.7.1";
  src = builtins.path {
    path = ./source;
    name = "multi_xml-0.7.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/multi_xml-0.7.1
        cp -r . $dest/gems/multi_xml-0.7.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/multi_xml-0.7.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "multi_xml"
      s.version = "0.7.1"
      s.summary = "multi_xml"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
