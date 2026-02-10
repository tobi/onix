#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# bouncy-castle-java 1.5.0147
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
  pname = "bouncy-castle-java";
  version = "1.5.0147";
  src = builtins.path {
    path = ./source;
    name = "bouncy-castle-java-1.5.0147-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/bouncy-castle-java-1.5.0147
        cp -r . $dest/gems/bouncy-castle-java-1.5.0147/
        mkdir -p $dest/specifications
        cat > $dest/specifications/bouncy-castle-java-1.5.0147.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "bouncy-castle-java"
      s.version = "1.5.0147"
      s.summary = "bouncy-castle-java"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
