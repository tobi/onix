#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# arel 7.1.4
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
  pname = "arel";
  version = "7.1.4";
  src = builtins.path {
    path = ./source;
    name = "arel-7.1.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/arel-7.1.4
        cp -r . $dest/gems/arel-7.1.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/arel-7.1.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "arel"
      s.version = "7.1.4"
      s.summary = "arel"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
