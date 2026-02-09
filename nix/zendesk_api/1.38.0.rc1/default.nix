#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# zendesk_api 1.38.0.rc1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "zendesk_api";
  version = "1.38.0.rc1";
  src = builtins.path { path = ./source; name = "zendesk_api-1.38.0.rc1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/zendesk_api-1.38.0.rc1
    cp -r . $dest/gems/zendesk_api-1.38.0.rc1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/zendesk_api-1.38.0.rc1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "zendesk_api"
  s.version = "1.38.0.rc1"
  s.summary = "zendesk_api"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
