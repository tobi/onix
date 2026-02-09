#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# orm_adapter 0.5.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "orm_adapter";
  version = "0.5.0";
  src = builtins.path { path = ./source; name = "orm_adapter-0.5.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/orm_adapter-0.5.0
    cp -r . $dest/gems/orm_adapter-0.5.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/orm_adapter-0.5.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "orm_adapter"
  s.version = "0.5.0"
  s.summary = "orm_adapter"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
