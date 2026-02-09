#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# erubi 1.13.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "erubi";
  version = "1.13.1";
  src = builtins.path { path = ./source; name = "erubi-1.13.1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/erubi-1.13.1
    cp -r . $dest/gems/erubi-1.13.1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/erubi-1.13.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "erubi"
  s.version = "1.13.1"
  s.summary = "erubi"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
