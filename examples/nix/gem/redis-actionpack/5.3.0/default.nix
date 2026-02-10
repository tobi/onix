#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis-actionpack 5.3.0
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
  pname = "redis-actionpack";
  version = "5.3.0";
  src = builtins.path {
    path = ./source;
    name = "redis-actionpack-5.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/redis-actionpack-5.3.0
        cp -r . $dest/gems/redis-actionpack-5.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/redis-actionpack-5.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "redis-actionpack"
      s.version = "5.3.0"
      s.summary = "redis-actionpack"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
