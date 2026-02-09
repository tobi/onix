#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# chewy 7.6.0
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
  pname = "chewy";
  version = "7.6.0";
  src = builtins.path {
    path = ./source;
    name = "chewy-7.6.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/chewy-7.6.0
        cp -r . $dest/gems/chewy-7.6.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/chewy-7.6.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "chewy"
      s.version = "7.6.0"
      s.summary = "chewy"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
