#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ancestry 4.3.3
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
  pname = "ancestry";
  version = "4.3.3";
  src = builtins.path {
    path = ./source;
    name = "ancestry-4.3.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/ancestry-4.3.3
        cp -r . $dest/gems/ancestry-4.3.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/ancestry-4.3.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "ancestry"
      s.version = "4.3.3"
      s.summary = "ancestry"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
