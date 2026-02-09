#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# addressable 2.8.8
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
  pname = "addressable";
  version = "2.8.8";
  src = builtins.path {
    path = ./source;
    name = "addressable-2.8.8-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/addressable-2.8.8
        cp -r . $dest/gems/addressable-2.8.8/
        mkdir -p $dest/specifications
        cat > $dest/specifications/addressable-2.8.8.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "addressable"
      s.version = "2.8.8"
      s.summary = "addressable"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
