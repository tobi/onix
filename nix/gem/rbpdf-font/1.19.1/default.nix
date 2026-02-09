#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rbpdf-font 1.19.1
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
  pname = "rbpdf-font";
  version = "1.19.1";
  src = builtins.path {
    path = ./source;
    name = "rbpdf-font-1.19.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rbpdf-font-1.19.1
        cp -r . $dest/gems/rbpdf-font-1.19.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rbpdf-font-1.19.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rbpdf-font"
      s.version = "1.19.1"
      s.summary = "rbpdf-font"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
