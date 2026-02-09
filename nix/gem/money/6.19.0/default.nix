#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# money 6.19.0
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
  pname = "money";
  version = "6.19.0";
  src = builtins.path {
    path = ./source;
    name = "money-6.19.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/money-6.19.0
        cp -r . $dest/gems/money-6.19.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/money-6.19.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "money"
      s.version = "6.19.0"
      s.summary = "money"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
