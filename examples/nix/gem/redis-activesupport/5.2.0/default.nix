#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis-activesupport 5.2.0
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
  pname = "redis-activesupport";
  version = "5.2.0";
  src = builtins.path {
    path = ./source;
    name = "redis-activesupport-5.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/redis-activesupport-5.2.0
        cp -r . $dest/gems/redis-activesupport-5.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/redis-activesupport-5.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "redis-activesupport"
      s.version = "5.2.0"
      s.summary = "redis-activesupport"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
