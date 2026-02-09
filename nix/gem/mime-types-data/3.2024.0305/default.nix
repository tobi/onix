#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mime-types-data 3.2024.0305
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
  pname = "mime-types-data";
  version = "3.2024.0305";
  src = builtins.path {
    path = ./source;
    name = "mime-types-data-3.2024.0305-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/mime-types-data-3.2024.0305
        cp -r . $dest/gems/mime-types-data-3.2024.0305/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mime-types-data-3.2024.0305.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mime-types-data"
      s.version = "3.2024.0305"
      s.summary = "mime-types-data"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
