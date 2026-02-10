#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# test-prof 1.3.3
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
  pname = "test-prof";
  version = "1.3.3";
  src = builtins.path {
    path = ./source;
    name = "test-prof-1.3.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/test-prof-1.3.3
        cp -r . $dest/gems/test-prof-1.3.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/test-prof-1.3.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "test-prof"
      s.version = "1.3.3"
      s.summary = "test-prof"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
