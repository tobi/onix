#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# flipper 0.25.4
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
  pname = "flipper";
  version = "0.25.4";
  src = builtins.path {
    path = ./source;
    name = "flipper-0.25.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/flipper-0.25.4
        cp -r . $dest/gems/flipper-0.25.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/flipper-0.25.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "flipper"
      s.version = "0.25.4"
      s.summary = "flipper"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
