#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mini_scheduler 0.18.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "mini_scheduler";
  version = "0.18.0";
  src = builtins.path { path = ./source; name = "mini_scheduler-0.18.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/mini_scheduler-0.18.0
    cp -r . $dest/gems/mini_scheduler-0.18.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/mini_scheduler-0.18.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "mini_scheduler"
  s.version = "0.18.0"
  s.summary = "mini_scheduler"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
