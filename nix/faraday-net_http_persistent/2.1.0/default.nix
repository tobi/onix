#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# faraday-net_http_persistent 2.1.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "faraday-net_http_persistent";
  version = "2.1.0";
  src = builtins.path { path = ./source; name = "faraday-net_http_persistent-2.1.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/faraday-net_http_persistent-2.1.0
    cp -r . $dest/gems/faraday-net_http_persistent-2.1.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/faraday-net_http_persistent-2.1.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "faraday-net_http_persistent"
  s.version = "2.1.0"
  s.summary = "faraday-net_http_persistent"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
