#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# connection_pool 3.0.1
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
  pname = "connection_pool";
  version = "3.0.1";
  src = builtins.path {
    path = ./source;
    name = "connection_pool-3.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/connection_pool-3.0.1
        cp -r . $dest/gems/connection_pool-3.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/connection_pool-3.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "connection_pool"
      s.version = "3.0.1"
      s.summary = "connection_pool"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
