#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# webrick 1.9.2
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
  pname = "webrick";
  version = "1.9.2";
  src = builtins.path {
    path = ./source;
    name = "webrick-1.9.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/webrick-1.9.2
        cp -r . $dest/gems/webrick-1.9.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/webrick-1.9.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "webrick"
      s.version = "1.9.2"
      s.summary = "webrick"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
