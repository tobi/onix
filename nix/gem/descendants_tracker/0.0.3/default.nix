#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# descendants_tracker 0.0.3
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
  pname = "descendants_tracker";
  version = "0.0.3";
  src = builtins.path {
    path = ./source;
    name = "descendants_tracker-0.0.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/descendants_tracker-0.0.3
        cp -r . $dest/gems/descendants_tracker-0.0.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/descendants_tracker-0.0.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "descendants_tracker"
      s.version = "0.0.3"
      s.summary = "descendants_tracker"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
