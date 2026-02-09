#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# solid_queue 1.2.4
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "solid_queue";
  version = "1.2.4";
  src = builtins.path { path = ./source; name = "solid_queue-1.2.4-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/solid_queue-1.2.4
    cp -r . $dest/gems/solid_queue-1.2.4/
    mkdir -p $dest/specifications
    cat > $dest/specifications/solid_queue-1.2.4.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "solid_queue"
  s.version = "1.2.4"
  s.summary = "solid_queue"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
