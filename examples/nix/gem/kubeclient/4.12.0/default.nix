#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# kubeclient 4.12.0
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
  pname = "kubeclient";
  version = "4.12.0";
  src = builtins.path {
    path = ./source;
    name = "kubeclient-4.12.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/kubeclient-4.12.0
        cp -r . $dest/gems/kubeclient-4.12.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/kubeclient-4.12.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "kubeclient"
      s.version = "4.12.0"
      s.summary = "kubeclient"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
