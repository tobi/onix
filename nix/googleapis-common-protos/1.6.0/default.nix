#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# googleapis-common-protos 1.6.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "googleapis-common-protos";
  version = "1.6.0";
  src = builtins.path { path = ./source; name = "googleapis-common-protos-1.6.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/googleapis-common-protos-1.6.0
    cp -r . $dest/gems/googleapis-common-protos-1.6.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/googleapis-common-protos-1.6.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "googleapis-common-protos"
  s.version = "1.6.0"
  s.summary = "googleapis-common-protos"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
