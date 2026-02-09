#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# actionpack 7.1.5.2
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
  pname = "actionpack";
  version = "7.1.5.2";
  src = builtins.path {
    path = ./source;
    name = "actionpack-7.1.5.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/actionpack-7.1.5.2
        cp -r . $dest/gems/actionpack-7.1.5.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/actionpack-7.1.5.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "actionpack"
      s.version = "7.1.5.2"
      s.summary = "actionpack"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
