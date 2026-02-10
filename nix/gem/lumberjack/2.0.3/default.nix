#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# lumberjack 2.0.3
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
  pname = "lumberjack";
  version = "2.0.3";
  src = builtins.path {
    path = ./source;
    name = "lumberjack-2.0.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/lumberjack-2.0.3
        cp -r . $dest/gems/lumberjack-2.0.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/lumberjack-2.0.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "lumberjack"
      s.version = "2.0.3"
      s.summary = "lumberjack"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
