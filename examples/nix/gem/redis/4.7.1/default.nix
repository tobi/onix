#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis 4.7.1
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
  pname = "redis";
  version = "4.7.1";
  src = builtins.path {
    path = ./source;
    name = "redis-4.7.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/redis-4.7.1
        cp -r . $dest/gems/redis-4.7.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/redis-4.7.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "redis"
      s.version = "4.7.1"
      s.summary = "redis"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
