#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# letter_opener_web 3.0.0
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
  pname = "letter_opener_web";
  version = "3.0.0";
  src = builtins.path {
    path = ./source;
    name = "letter_opener_web-3.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/letter_opener_web-3.0.0
        cp -r . $dest/gems/letter_opener_web-3.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/letter_opener_web-3.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "letter_opener_web"
      s.version = "3.0.0"
      s.summary = "letter_opener_web"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
