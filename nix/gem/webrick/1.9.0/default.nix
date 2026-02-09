#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# webrick 1.9.0
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  bundle_path = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "webrick";
  version = "1.9.0";
  src = builtins.path {
    path = ./source;
    name = "webrick-1.9.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/webrick-1.9.0
        cp -r . $dest/gems/webrick-1.9.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/webrick-1.9.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "webrick"
      s.version = "1.9.0"
      s.summary = "webrick"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
