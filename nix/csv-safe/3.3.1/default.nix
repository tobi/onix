#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# csv-safe 3.3.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "csv-safe";
  version = "3.3.1";
  src = builtins.path { path = ./source; name = "csv-safe-3.3.1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/csv-safe-3.3.1
    cp -r . $dest/gems/csv-safe-3.3.1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/csv-safe-3.3.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "csv-safe"
  s.version = "3.3.1"
  s.summary = "csv-safe"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
