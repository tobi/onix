#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis-store 1.9.2
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
  pname = "redis-store";
  version = "1.9.2";
  src = builtins.path {
    path = ./source;
    name = "redis-store-1.9.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/redis-store-1.9.2
        cp -r . $dest/gems/redis-store-1.9.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/redis-store-1.9.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "redis-store"
      s.version = "1.9.2"
      s.summary = "redis-store"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
