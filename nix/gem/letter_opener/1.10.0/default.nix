#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# letter_opener 1.10.0
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "letter_opener";
  version = "1.10.0";
  src = builtins.path {
    path = ./source;
    name = "letter_opener-1.10.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/letter_opener-1.10.0
        cp -r . $dest/gems/letter_opener-1.10.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/letter_opener-1.10.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "letter_opener"
      s.version = "1.10.0"
      s.summary = "letter_opener"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
