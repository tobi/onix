#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack 3.2.3
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "rack";
  version = "3.2.3";
  src = builtins.path { path = ./source; name = "rack-3.2.3-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/rack-3.2.3
    cp -r . $dest/gems/rack-3.2.3/
    mkdir -p $dest/specifications
    cat > $dest/specifications/rack-3.2.3.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "rack"
  s.version = "3.2.3"
  s.summary = "rack"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
