#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# uglifier 4.2.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "uglifier";
  version = "4.2.0";
  src = builtins.path { path = ./source; name = "uglifier-4.2.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/uglifier-4.2.0
    cp -r . $dest/gems/uglifier-4.2.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/uglifier-4.2.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "uglifier"
  s.version = "4.2.0"
  s.summary = "uglifier"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
