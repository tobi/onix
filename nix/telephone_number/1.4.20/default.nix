#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# telephone_number 1.4.20
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "telephone_number";
  version = "1.4.20";
  src = builtins.path { path = ./source; name = "telephone_number-1.4.20-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/telephone_number-1.4.20
    cp -r . $dest/gems/telephone_number-1.4.20/
    mkdir -p $dest/specifications
    cat > $dest/specifications/telephone_number-1.4.20.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "telephone_number"
  s.version = "1.4.20"
  s.summary = "telephone_number"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
