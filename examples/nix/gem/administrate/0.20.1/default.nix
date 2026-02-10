#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# administrate 0.20.1
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
  pname = "administrate";
  version = "0.20.1";
  src = builtins.path {
    path = ./source;
    name = "administrate-0.20.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/administrate-0.20.1
        cp -r . $dest/gems/administrate-0.20.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/administrate-0.20.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "administrate"
      s.version = "0.20.1"
      s.summary = "administrate"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
