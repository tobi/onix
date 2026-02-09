#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# axiom-types 0.0.5
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
  pname = "axiom-types";
  version = "0.0.5";
  src = builtins.path {
    path = ./source;
    name = "axiom-types-0.0.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/axiom-types-0.0.5
        cp -r . $dest/gems/axiom-types-0.0.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/axiom-types-0.0.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "axiom-types"
      s.version = "0.0.5"
      s.summary = "axiom-types"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
