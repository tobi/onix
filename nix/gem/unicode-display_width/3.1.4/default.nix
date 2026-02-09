#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# unicode-display_width 3.1.4
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
  pname = "unicode-display_width";
  version = "3.1.4";
  src = builtins.path {
    path = ./source;
    name = "unicode-display_width-3.1.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/unicode-display_width-3.1.4
        cp -r . $dest/gems/unicode-display_width-3.1.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/unicode-display_width-3.1.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "unicode-display_width"
      s.version = "3.1.4"
      s.summary = "unicode-display_width"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
