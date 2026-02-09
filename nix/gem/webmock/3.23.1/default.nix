#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# webmock 3.23.1
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
  pname = "webmock";
  version = "3.23.1";
  src = builtins.path {
    path = ./source;
    name = "webmock-3.23.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/webmock-3.23.1
        cp -r . $dest/gems/webmock-3.23.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/webmock-3.23.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "webmock"
      s.version = "3.23.1"
      s.summary = "webmock"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
