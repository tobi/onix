#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ferrum 0.14
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
  pname = "ferrum";
  version = "0.14";
  src = builtins.path {
    path = ./source;
    name = "ferrum-0.14-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ferrum-0.14
        cp -r . $dest/gems/ferrum-0.14/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ferrum-0.14.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ferrum"
      s.version = "0.14"
      s.summary = "ferrum"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
