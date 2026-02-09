#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dry-inflector 1.2.0
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
  pname = "dry-inflector";
  version = "1.2.0";
  src = builtins.path {
    path = ./source;
    name = "dry-inflector-1.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/dry-inflector-1.2.0
        cp -r . $dest/gems/dry-inflector-1.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/dry-inflector-1.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "dry-inflector"
      s.version = "1.2.0"
      s.summary = "dry-inflector"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
