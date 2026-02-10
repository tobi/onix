#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dry-equalizer 0.2.2
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
  pname = "dry-equalizer";
  version = "0.2.2";
  src = builtins.path {
    path = ./source;
    name = "dry-equalizer-0.2.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/dry-equalizer-0.2.2
        cp -r . $dest/gems/dry-equalizer-0.2.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/dry-equalizer-0.2.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "dry-equalizer"
      s.version = "0.2.2"
      s.summary = "dry-equalizer"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
