#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack-proxy 0.7.6
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
  pname = "rack-proxy";
  version = "0.7.6";
  src = builtins.path {
    path = ./source;
    name = "rack-proxy-0.7.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rack-proxy-0.7.6
        cp -r . $dest/gems/rack-proxy-0.7.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rack-proxy-0.7.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rack-proxy"
      s.version = "0.7.6"
      s.summary = "rack-proxy"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
