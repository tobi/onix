#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis-client 0.22.2
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
  pname = "redis-client";
  version = "0.22.2";
  src = builtins.path {
    path = ./source;
    name = "redis-client-0.22.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/redis-client-0.22.2
        cp -r . $dest/gems/redis-client-0.22.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/redis-client-0.22.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "redis-client"
      s.version = "0.22.2"
      s.summary = "redis-client"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
