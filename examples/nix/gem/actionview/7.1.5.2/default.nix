#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# actionview 7.1.5.2
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
  pname = "actionview";
  version = "7.1.5.2";
  src = builtins.path {
    path = ./source;
    name = "actionview-7.1.5.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/actionview-7.1.5.2
        cp -r . $dest/gems/actionview-7.1.5.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/actionview-7.1.5.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "actionview"
      s.version = "7.1.5.2"
      s.summary = "actionview"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
