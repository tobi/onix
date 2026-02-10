#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-http-persistent 4.0.8
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
  pname = "net-http-persistent";
  version = "4.0.8";
  src = builtins.path {
    path = ./source;
    name = "net-http-persistent-4.0.8-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/net-http-persistent-4.0.8
        cp -r . $dest/gems/net-http-persistent-4.0.8/
        mkdir -p $dest/specifications
        cat > $dest/specifications/net-http-persistent-4.0.8.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "net-http-persistent"
      s.version = "4.0.8"
      s.summary = "net-http-persistent"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
