#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dry-core 1.1.0
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
  pname = "dry-core";
  version = "1.1.0";
  src = builtins.path {
    path = ./source;
    name = "dry-core-1.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/dry-core-1.1.0
        cp -r . $dest/gems/dry-core-1.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/dry-core-1.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "dry-core"
      s.version = "1.1.0"
      s.summary = "dry-core"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
