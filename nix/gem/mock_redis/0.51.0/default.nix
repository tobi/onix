#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mock_redis 0.51.0
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
  pname = "mock_redis";
  version = "0.51.0";
  src = builtins.path {
    path = ./source;
    name = "mock_redis-0.51.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/mock_redis-0.51.0
        cp -r . $dest/gems/mock_redis-0.51.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mock_redis-0.51.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mock_redis"
      s.version = "0.51.0"
      s.summary = "mock_redis"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
