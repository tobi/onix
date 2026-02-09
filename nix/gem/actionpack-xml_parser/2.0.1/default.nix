#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# actionpack-xml_parser 2.0.1
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
  pname = "actionpack-xml_parser";
  version = "2.0.1";
  src = builtins.path {
    path = ./source;
    name = "actionpack-xml_parser-2.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/actionpack-xml_parser-2.0.1
        cp -r . $dest/gems/actionpack-xml_parser-2.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/actionpack-xml_parser-2.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "actionpack-xml_parser"
      s.version = "2.0.1"
      s.summary = "actionpack-xml_parser"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
