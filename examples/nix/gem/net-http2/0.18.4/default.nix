#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# net-http2 0.18.4
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
  pname = "net-http2";
  version = "0.18.4";
  src = builtins.path {
    path = ./source;
    name = "net-http2-0.18.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/net-http2-0.18.4
        cp -r . $dest/gems/net-http2-0.18.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/net-http2-0.18.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "net-http2"
      s.version = "0.18.4"
      s.summary = "net-http2"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
