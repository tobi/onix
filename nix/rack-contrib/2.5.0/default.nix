#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack-contrib 2.5.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "rack-contrib";
  version = "2.5.0";
  src = builtins.path { path = ./source; name = "rack-contrib-2.5.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/rack-contrib-2.5.0
    cp -r . $dest/gems/rack-contrib-2.5.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/rack-contrib-2.5.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "rack-contrib"
  s.version = "2.5.0"
  s.summary = "rack-contrib"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
