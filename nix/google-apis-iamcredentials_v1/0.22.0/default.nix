#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-apis-iamcredentials_v1 0.22.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "google-apis-iamcredentials_v1";
  version = "0.22.0";
  src = builtins.path { path = ./source; name = "google-apis-iamcredentials_v1-0.22.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/google-apis-iamcredentials_v1-0.22.0
    cp -r . $dest/gems/google-apis-iamcredentials_v1-0.22.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/google-apis-iamcredentials_v1-0.22.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "google-apis-iamcredentials_v1"
  s.version = "0.22.0"
  s.summary = "google-apis-iamcredentials_v1"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
