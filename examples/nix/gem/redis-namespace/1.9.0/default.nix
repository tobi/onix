#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis-namespace 1.9.0
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
  pname = "redis-namespace";
  version = "1.9.0";
  src = builtins.path {
    path = ./source;
    name = "redis-namespace-1.9.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/redis-namespace-1.9.0
        cp -r . $dest/gems/redis-namespace-1.9.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/redis-namespace-1.9.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "redis-namespace"
      s.version = "1.9.0"
      s.summary = "redis-namespace"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
