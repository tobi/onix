#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# line-bot-api 1.28.0
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
  pname = "line-bot-api";
  version = "1.28.0";
  src = builtins.path {
    path = ./source;
    name = "line-bot-api-1.28.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/line-bot-api-1.28.0
        cp -r . $dest/gems/line-bot-api-1.28.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/line-bot-api-1.28.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "line-bot-api"
      s.version = "1.28.0"
      s.summary = "line-bot-api"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
