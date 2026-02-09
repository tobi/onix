#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# benchmark 0.4.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "benchmark";
  version = "0.4.1";
  src = builtins.path { path = ./source; name = "benchmark-0.4.1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/benchmark-0.4.1
    cp -r . $dest/gems/benchmark-0.4.1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/benchmark-0.4.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "benchmark"
  s.version = "0.4.1"
  s.summary = "benchmark"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
