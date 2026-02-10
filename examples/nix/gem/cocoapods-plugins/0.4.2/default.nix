#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cocoapods-plugins 0.4.2
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
  pname = "cocoapods-plugins";
  version = "0.4.2";
  src = builtins.path {
    path = ./source;
    name = "cocoapods-plugins-0.4.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/cocoapods-plugins-0.4.2
        cp -r . $dest/gems/cocoapods-plugins-0.4.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/cocoapods-plugins-0.4.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "cocoapods-plugins"
      s.version = "0.4.2"
      s.summary = "cocoapods-plugins"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
