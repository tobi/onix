#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# kaminari-actionview 1.2.0
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
  pname = "kaminari-actionview";
  version = "1.2.0";
  src = builtins.path {
    path = ./source;
    name = "kaminari-actionview-1.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/kaminari-actionview-1.2.0
        cp -r . $dest/gems/kaminari-actionview-1.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/kaminari-actionview-1.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "kaminari-actionview"
      s.version = "1.2.0"
      s.summary = "kaminari-actionview"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
