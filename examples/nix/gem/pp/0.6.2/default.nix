#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pp 0.6.2
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
  pname = "pp";
  version = "0.6.2";
  src = builtins.path {
    path = ./source;
    name = "pp-0.6.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/pp-0.6.2
        cp -r . $dest/gems/pp-0.6.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/pp-0.6.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "pp"
      s.version = "0.6.2"
      s.summary = "pp"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
