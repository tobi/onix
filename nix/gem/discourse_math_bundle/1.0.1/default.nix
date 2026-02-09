#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# discourse_math_bundle 1.0.1
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
  pname = "discourse_math_bundle";
  version = "1.0.1";
  src = builtins.path {
    path = ./source;
    name = "discourse_math_bundle-1.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/discourse_math_bundle-1.0.1
        cp -r . $dest/gems/discourse_math_bundle-1.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/discourse_math_bundle-1.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "discourse_math_bundle"
      s.version = "1.0.1"
      s.summary = "discourse_math_bundle"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
