#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# logster 2.20.1
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
  pname = "logster";
  version = "2.20.1";
  src = builtins.path {
    path = ./source;
    name = "logster-2.20.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/logster-2.20.1
        cp -r . $dest/gems/logster-2.20.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/logster-2.20.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "logster"
      s.version = "2.20.1"
      s.summary = "logster"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
