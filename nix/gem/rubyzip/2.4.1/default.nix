#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubyzip 2.4.1
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
  pname = "rubyzip";
  version = "2.4.1";
  src = builtins.path {
    path = ./source;
    name = "rubyzip-2.4.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/rubyzip-2.4.1
        cp -r . $dest/gems/rubyzip-2.4.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rubyzip-2.4.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rubyzip"
      s.version = "2.4.1"
      s.summary = "rubyzip"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
