#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-net_http 3.4.2
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
  pname = "faraday-net_http";
  version = "3.4.2";
  src = builtins.path {
    path = ./source;
    name = "faraday-net_http-3.4.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/faraday-net_http-3.4.2
        cp -r . $dest/gems/faraday-net_http-3.4.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/faraday-net_http-3.4.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "faraday-net_http"
      s.version = "3.4.2"
      s.summary = "faraday-net_http"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
