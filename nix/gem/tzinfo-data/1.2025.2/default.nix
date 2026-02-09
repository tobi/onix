#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tzinfo-data 1.2025.2
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
  pname = "tzinfo-data";
  version = "1.2025.2";
  src = builtins.path {
    path = ./source;
    name = "tzinfo-data-1.2025.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/tzinfo-data-1.2025.2
        cp -r . $dest/gems/tzinfo-data-1.2025.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/tzinfo-data-1.2025.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "tzinfo-data"
      s.version = "1.2025.2"
      s.summary = "tzinfo-data"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
