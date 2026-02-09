#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack-test 2.1.0
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "rack-test";
  version = "2.1.0";
  src = builtins.path {
    path = ./source;
    name = "rack-test-2.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/rack-test-2.1.0
        cp -r . $dest/gems/rack-test-2.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rack-test-2.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rack-test"
      s.version = "2.1.0"
      s.summary = "rack-test"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
