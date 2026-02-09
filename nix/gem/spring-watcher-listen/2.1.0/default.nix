#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# spring-watcher-listen 2.1.0
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
  pname = "spring-watcher-listen";
  version = "2.1.0";
  src = builtins.path {
    path = ./source;
    name = "spring-watcher-listen-2.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/spring-watcher-listen-2.1.0
        cp -r . $dest/gems/spring-watcher-listen-2.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/spring-watcher-listen-2.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "spring-watcher-listen"
      s.version = "2.1.0"
      s.summary = "spring-watcher-listen"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
