#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# name_of_person 1.1.3
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
  pname = "name_of_person";
  version = "1.1.3";
  src = builtins.path {
    path = ./source;
    name = "name_of_person-1.1.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/name_of_person-1.1.3
        cp -r . $dest/gems/name_of_person-1.1.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/name_of_person-1.1.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "name_of_person"
      s.version = "1.1.3"
      s.summary = "name_of_person"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
