#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# retriable 3.1.2
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
  pname = "retriable";
  version = "3.1.2";
  src = builtins.path {
    path = ./source;
    name = "retriable-3.1.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/retriable-3.1.2
        cp -r . $dest/gems/retriable-3.1.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/retriable-3.1.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "retriable"
      s.version = "3.1.2"
      s.summary = "retriable"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
