#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mime-types-data 3.2025.0924
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "mime-types-data";
  version = "3.2025.0924";
  src = builtins.path {
    path = ./source;
    name = "mime-types-data-3.2025.0924-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/mime-types-data-3.2025.0924
        cp -r . $dest/gems/mime-types-data-3.2025.0924/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mime-types-data-3.2025.0924.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mime-types-data"
      s.version = "3.2025.0924"
      s.summary = "mime-types-data"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
