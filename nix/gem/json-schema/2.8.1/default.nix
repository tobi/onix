#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# json-schema 2.8.1
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
  pname = "json-schema";
  version = "2.8.1";
  src = builtins.path {
    path = ./source;
    name = "json-schema-2.8.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/json-schema-2.8.1
        cp -r . $dest/gems/json-schema-2.8.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/json-schema-2.8.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "json-schema"
      s.version = "2.8.1"
      s.summary = "json-schema"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
