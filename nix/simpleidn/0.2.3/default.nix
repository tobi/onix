#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simpleidn 0.2.3
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "simpleidn";
  version = "0.2.3";
  src = builtins.path { path = ./source; name = "simpleidn-0.2.3-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/simpleidn-0.2.3
    cp -r . $dest/gems/simpleidn-0.2.3/
    mkdir -p $dest/specifications
    cat > $dest/specifications/simpleidn-0.2.3.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "simpleidn"
  s.version = "0.2.3"
  s.summary = "simpleidn"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
