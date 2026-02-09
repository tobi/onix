#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mission_control-jobs 1.1.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "mission_control-jobs";
  version = "1.1.0";
  src = builtins.path { path = ./source; name = "mission_control-jobs-1.1.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/mission_control-jobs-1.1.0
    cp -r . $dest/gems/mission_control-jobs-1.1.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/mission_control-jobs-1.1.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "mission_control-jobs"
  s.version = "1.1.0"
  s.summary = "mission_control-jobs"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
