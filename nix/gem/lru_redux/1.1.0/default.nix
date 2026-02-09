#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# lru_redux 1.1.0
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
  pname = "lru_redux";
  version = "1.1.0";
  src = builtins.path {
    path = ./source;
    name = "lru_redux-1.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/lru_redux-1.1.0
        cp -r . $dest/gems/lru_redux-1.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/lru_redux-1.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "lru_redux"
      s.version = "1.1.0"
      s.summary = "lru_redux"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
