#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# childprocess 5.1.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "childprocess";
  version = "5.1.0";
  src = builtins.path { path = ./source; name = "childprocess-5.1.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/childprocess-5.1.0
    cp -r . $dest/gems/childprocess-5.1.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/childprocess-5.1.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "childprocess"
  s.version = "5.1.0"
  s.summary = "childprocess"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
