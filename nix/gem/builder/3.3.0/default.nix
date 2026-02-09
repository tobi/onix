#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# builder 3.3.0
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
  pname = "builder";
  version = "3.3.0";
  src = builtins.path {
    path = ./source;
    name = "builder-3.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/builder-3.3.0
        cp -r . $dest/gems/builder-3.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/builder-3.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "builder"
      s.version = "3.3.0"
      s.summary = "builder"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
