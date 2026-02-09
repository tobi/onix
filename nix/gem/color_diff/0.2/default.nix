#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# color_diff 0.2
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
  pname = "color_diff";
  version = "0.2";
  src = builtins.path {
    path = ./source;
    name = "color_diff-0.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/color_diff-0.2
        cp -r . $dest/gems/color_diff-0.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/color_diff-0.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "color_diff"
      s.version = "0.2"
      s.summary = "color_diff"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
