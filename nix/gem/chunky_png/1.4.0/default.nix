#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# chunky_png 1.4.0
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
  pname = "chunky_png";
  version = "1.4.0";
  src = builtins.path {
    path = ./source;
    name = "chunky_png-1.4.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/chunky_png-1.4.0
        cp -r . $dest/gems/chunky_png-1.4.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/chunky_png-1.4.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "chunky_png"
      s.version = "1.4.0"
      s.summary = "chunky_png"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
