#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis 5.4.0
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
  pname = "redis";
  version = "5.4.0";
  src = builtins.path {
    path = ./source;
    name = "redis-5.4.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/redis-5.4.0
        cp -r . $dest/gems/redis-5.4.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/redis-5.4.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "redis"
      s.version = "5.4.0"
      s.summary = "redis"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
