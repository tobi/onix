#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mime-types-data 3.2026.0113
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
  version = "3.2026.0113";
  src = builtins.path {
    path = ./source;
    name = "mime-types-data-3.2026.0113-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/mime-types-data-3.2026.0113
        cp -r . $dest/gems/mime-types-data-3.2026.0113/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mime-types-data-3.2026.0113.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mime-types-data"
      s.version = "3.2026.0113"
      s.summary = "mime-types-data"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
