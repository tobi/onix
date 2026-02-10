#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# image_size 3.4.0
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
  pname = "image_size";
  version = "3.4.0";
  src = builtins.path {
    path = ./source;
    name = "image_size-3.4.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/image_size-3.4.0
        cp -r . $dest/gems/image_size-3.4.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/image_size-3.4.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "image_size"
      s.version = "3.4.0"
      s.summary = "image_size"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
