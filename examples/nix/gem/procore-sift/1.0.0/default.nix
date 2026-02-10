#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# procore-sift 1.0.0
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
  pname = "procore-sift";
  version = "1.0.0";
  src = builtins.path {
    path = ./source;
    name = "procore-sift-1.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/procore-sift-1.0.0
        cp -r . $dest/gems/procore-sift-1.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/procore-sift-1.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "procore-sift"
      s.version = "1.0.0"
      s.summary = "procore-sift"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
