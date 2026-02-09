#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sanitize 7.0.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "sanitize";
  version = "7.0.0";
  src = builtins.path { path = ./source; name = "sanitize-7.0.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/sanitize-7.0.0
    cp -r . $dest/gems/sanitize-7.0.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/sanitize-7.0.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "sanitize"
  s.version = "7.0.0"
  s.summary = "sanitize"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
