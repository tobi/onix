#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-http 0.9.1
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
  pname = "net-http";
  version = "0.9.1";
  src = builtins.path {
    path = ./source;
    name = "net-http-0.9.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/net-http-0.9.1
        cp -r . $dest/gems/net-http-0.9.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/net-http-0.9.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "net-http"
      s.version = "0.9.1"
      s.summary = "net-http"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
