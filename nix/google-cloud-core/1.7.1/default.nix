#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# google-cloud-core 1.7.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "google-cloud-core";
  version = "1.7.1";
  src = builtins.path { path = ./source; name = "google-cloud-core-1.7.1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/google-cloud-core-1.7.1
    cp -r . $dest/gems/google-cloud-core-1.7.1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/google-cloud-core-1.7.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "google-cloud-core"
  s.version = "1.7.1"
  s.summary = "google-cloud-core"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
