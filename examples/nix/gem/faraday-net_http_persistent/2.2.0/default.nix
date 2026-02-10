#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-net_http_persistent 2.2.0
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
  pname = "faraday-net_http_persistent";
  version = "2.2.0";
  src = builtins.path {
    path = ./source;
    name = "faraday-net_http_persistent-2.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/faraday-net_http_persistent-2.2.0
        cp -r . $dest/gems/faraday-net_http_persistent-2.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/faraday-net_http_persistent-2.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "faraday-net_http_persistent"
      s.version = "2.2.0"
      s.summary = "faraday-net_http_persistent"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
