#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cocoapods-deintegrate 1.0.5
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
  pname = "cocoapods-deintegrate";
  version = "1.0.5";
  src = builtins.path {
    path = ./source;
    name = "cocoapods-deintegrate-1.0.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/cocoapods-deintegrate-1.0.5
        cp -r . $dest/gems/cocoapods-deintegrate-1.0.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/cocoapods-deintegrate-1.0.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "cocoapods-deintegrate"
      s.version = "1.0.5"
      s.summary = "cocoapods-deintegrate"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
