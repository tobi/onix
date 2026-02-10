#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# lumberjack 1.2.9
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
  version = "1.2.9";
  src = builtins.path {
    path = ./source;
    name = "lumberjack-1.2.9-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/lumberjack-1.2.9
        cp -r . $dest/gems/lumberjack-1.2.9/
        mkdir -p $dest/specifications
        cat > $dest/specifications/lumberjack-1.2.9.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "lumberjack"
      s.version = "1.2.9"
      s.summary = "lumberjack"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
