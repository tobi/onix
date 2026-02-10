#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# tzinfo-data 1.2023.3
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
  pname = "tzinfo-data";
  version = "1.2023.3";
  src = builtins.path {
    path = ./source;
    name = "tzinfo-data-1.2023.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/tzinfo-data-1.2023.3
        cp -r . $dest/gems/tzinfo-data-1.2023.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/tzinfo-data-1.2023.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "tzinfo-data"
      s.version = "1.2023.3"
      s.summary = "tzinfo-data"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
