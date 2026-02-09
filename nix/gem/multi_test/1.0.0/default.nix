#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# multi_test 1.0.0
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
  pname = "multi_test";
  version = "1.0.0";
  src = builtins.path {
    path = ./source;
    name = "multi_test-1.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/multi_test-1.0.0
        cp -r . $dest/gems/multi_test-1.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/multi_test-1.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "multi_test"
      s.version = "1.0.0"
      s.summary = "multi_test"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
