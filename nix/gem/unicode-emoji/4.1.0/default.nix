#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# unicode-emoji 4.1.0
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
  pname = "unicode-emoji";
  version = "4.1.0";
  src = builtins.path {
    path = ./source;
    name = "unicode-emoji-4.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/unicode-emoji-4.1.0
        cp -r . $dest/gems/unicode-emoji-4.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/unicode-emoji-4.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "unicode-emoji"
      s.version = "4.1.0"
      s.summary = "unicode-emoji"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
