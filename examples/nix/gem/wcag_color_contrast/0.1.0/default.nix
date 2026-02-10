#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# wcag_color_contrast 0.1.0
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
  pname = "wcag_color_contrast";
  version = "0.1.0";
  src = builtins.path {
    path = ./source;
    name = "wcag_color_contrast-0.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/wcag_color_contrast-0.1.0
        cp -r . $dest/gems/wcag_color_contrast-0.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/wcag_color_contrast-0.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "wcag_color_contrast"
      s.version = "0.1.0"
      s.summary = "wcag_color_contrast"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
