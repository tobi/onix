#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cocoapods-trunk 1.4.1
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
  pname = "cocoapods-trunk";
  version = "1.4.1";
  src = builtins.path {
    path = ./source;
    name = "cocoapods-trunk-1.4.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/cocoapods-trunk-1.4.1
        cp -r . $dest/gems/cocoapods-trunk-1.4.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/cocoapods-trunk-1.4.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "cocoapods-trunk"
      s.version = "1.4.1"
      s.summary = "cocoapods-trunk"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
