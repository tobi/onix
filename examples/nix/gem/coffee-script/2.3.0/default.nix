#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# coffee-script 2.3.0
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
  pname = "coffee-script";
  version = "2.3.0";
  src = builtins.path {
    path = ./source;
    name = "coffee-script-2.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/coffee-script-2.3.0
        cp -r . $dest/gems/coffee-script-2.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/coffee-script-2.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "coffee-script"
      s.version = "2.3.0"
      s.summary = "coffee-script"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
