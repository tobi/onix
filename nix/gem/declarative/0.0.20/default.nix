#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# declarative 0.0.20
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
  pname = "declarative";
  version = "0.0.20";
  src = builtins.path {
    path = ./source;
    name = "declarative-0.0.20-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/declarative-0.0.20
        cp -r . $dest/gems/declarative-0.0.20/
        mkdir -p $dest/specifications
        cat > $dest/specifications/declarative-0.0.20.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "declarative"
      s.version = "0.0.20"
      s.summary = "declarative"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
