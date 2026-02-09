#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rswag-specs 2.17.0
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
  pname = "rswag-specs";
  version = "2.17.0";
  src = builtins.path {
    path = ./source;
    name = "rswag-specs-2.17.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rswag-specs-2.17.0
        cp -r . $dest/gems/rswag-specs-2.17.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rswag-specs-2.17.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rswag-specs"
      s.version = "2.17.0"
      s.summary = "rswag-specs"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
