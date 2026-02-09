#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# actionview 8.0.4
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "actionview";
  version = "8.0.4";
  src = builtins.path { path = ./source; name = "actionview-8.0.4-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/actionview-8.0.4
    cp -r . $dest/gems/actionview-8.0.4/
    mkdir -p $dest/specifications
    cat > $dest/specifications/actionview-8.0.4.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "actionview"
  s.version = "8.0.4"
  s.summary = "actionview"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
