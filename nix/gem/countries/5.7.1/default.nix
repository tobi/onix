#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# countries 5.7.1
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
  pname = "countries";
  version = "5.7.1";
  src = builtins.path {
    path = ./source;
    name = "countries-5.7.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/countries-5.7.1
        cp -r . $dest/gems/countries-5.7.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/countries-5.7.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "countries"
      s.version = "5.7.1"
      s.summary = "countries"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
