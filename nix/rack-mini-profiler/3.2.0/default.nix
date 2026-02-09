#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rack-mini-profiler 3.2.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "rack-mini-profiler";
  version = "3.2.0";
  src = builtins.path { path = ./source; name = "rack-mini-profiler-3.2.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/rack-mini-profiler-3.2.0
    cp -r . $dest/gems/rack-mini-profiler-3.2.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/rack-mini-profiler-3.2.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "rack-mini-profiler"
  s.version = "3.2.0"
  s.summary = "rack-mini-profiler"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
