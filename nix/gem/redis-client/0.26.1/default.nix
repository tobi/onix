#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# redis-client 0.26.1
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
  version = "0.26.1";
  src = builtins.path {
    path = ./source;
    name = "redis-client-0.26.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/redis-client-0.26.1
        cp -r . $dest/gems/redis-client-0.26.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/redis-client-0.26.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "redis-client"
      s.version = "0.26.1"
      s.summary = "redis-client"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
