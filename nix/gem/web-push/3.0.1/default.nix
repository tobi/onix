#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# web-push 3.0.1
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
  pname = "web-push";
  version = "3.0.1";
  src = builtins.path {
    path = ./source;
    name = "web-push-3.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/web-push-3.0.1
        cp -r . $dest/gems/web-push-3.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/web-push-3.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "web-push"
      s.version = "3.0.1"
      s.summary = "web-push"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
