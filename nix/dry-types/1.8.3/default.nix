#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dry-types 1.8.3
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "dry-types";
  version = "1.8.3";
  src = builtins.path { path = ./source; name = "dry-types-1.8.3-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/dry-types-1.8.3
    cp -r . $dest/gems/dry-types-1.8.3/
    mkdir -p $dest/specifications
    cat > $dest/specifications/dry-types-1.8.3.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "dry-types"
  s.version = "1.8.3"
  s.summary = "dry-types"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
