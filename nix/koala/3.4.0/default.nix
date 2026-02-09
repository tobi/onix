#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# koala 3.4.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "koala";
  version = "3.4.0";
  src = builtins.path { path = ./source; name = "koala-3.4.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/koala-3.4.0
    cp -r . $dest/gems/koala-3.4.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/koala-3.4.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "koala"
  s.version = "3.4.0"
  s.summary = "koala"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
