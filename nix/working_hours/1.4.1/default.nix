#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# working_hours 1.4.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "working_hours";
  version = "1.4.1";
  src = builtins.path { path = ./source; name = "working_hours-1.4.1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/working_hours-1.4.1
    cp -r . $dest/gems/working_hours-1.4.1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/working_hours-1.4.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "working_hours"
  s.version = "1.4.1"
  s.summary = "working_hours"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
