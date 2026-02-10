#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# roo 3.0.0
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
  pname = "roo";
  version = "3.0.0";
  src = builtins.path {
    path = ./source;
    name = "roo-3.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/roo-3.0.0
        cp -r . $dest/gems/roo-3.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/roo-3.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "roo"
      s.version = "3.0.0"
      s.summary = "roo"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
