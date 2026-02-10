#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# kaminari-core 1.2.1
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
  pname = "kaminari-core";
  version = "1.2.1";
  src = builtins.path {
    path = ./source;
    name = "kaminari-core-1.2.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/kaminari-core-1.2.1
        cp -r . $dest/gems/kaminari-core-1.2.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/kaminari-core-1.2.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "kaminari-core"
      s.version = "1.2.1"
      s.summary = "kaminari-core"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
