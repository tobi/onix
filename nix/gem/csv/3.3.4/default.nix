#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# csv 3.3.4
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
  pname = "csv";
  version = "3.3.4";
  src = builtins.path {
    path = ./source;
    name = "csv-3.3.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/csv-3.3.4
        cp -r . $dest/gems/csv-3.3.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/csv-3.3.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "csv"
      s.version = "3.3.4"
      s.summary = "csv"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
