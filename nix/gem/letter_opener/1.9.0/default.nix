#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# letter_opener 1.9.0
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
  pname = "letter_opener";
  version = "1.9.0";
  src = builtins.path {
    path = ./source;
    name = "letter_opener-1.9.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/letter_opener-1.9.0
        cp -r . $dest/gems/letter_opener-1.9.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/letter_opener-1.9.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "letter_opener"
      s.version = "1.9.0"
      s.summary = "letter_opener"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
