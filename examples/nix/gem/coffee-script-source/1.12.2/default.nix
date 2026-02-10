#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# coffee-script-source 1.12.2
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
  pname = "coffee-script-source";
  version = "1.12.2";
  src = builtins.path {
    path = ./source;
    name = "coffee-script-source-1.12.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/coffee-script-source-1.12.2
        cp -r . $dest/gems/coffee-script-source-1.12.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/coffee-script-source-1.12.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "coffee-script-source"
      s.version = "1.12.2"
      s.summary = "coffee-script-source"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
