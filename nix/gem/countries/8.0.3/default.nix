#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# countries 8.0.3
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
  version = "8.0.3";
  src = builtins.path {
    path = ./source;
    name = "countries-8.0.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/countries-8.0.3
        cp -r . $dest/gems/countries-8.0.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/countries-8.0.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "countries"
      s.version = "8.0.3"
      s.summary = "countries"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
