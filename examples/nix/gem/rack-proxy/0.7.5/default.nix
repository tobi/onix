#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack-proxy 0.7.5
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
  version = "0.7.5";
  src = builtins.path {
    path = ./source;
    name = "rack-proxy-0.7.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rack-proxy-0.7.5
        cp -r . $dest/gems/rack-proxy-0.7.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rack-proxy-0.7.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rack-proxy"
      s.version = "0.7.5"
      s.summary = "rack-proxy"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
