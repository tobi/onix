#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fastimage 2.3.0
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
  pname = "fastimage";
  version = "2.3.0";
  src = builtins.path {
    path = ./source;
    name = "fastimage-2.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fastimage-2.3.0
        cp -r . $dest/gems/fastimage-2.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fastimage-2.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fastimage"
      s.version = "2.3.0"
      s.summary = "fastimage"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
