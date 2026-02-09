#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# barnes 0.0.9
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "barnes";
  version = "0.0.9";
  src = builtins.path { path = ./source; name = "barnes-0.0.9-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/barnes-0.0.9
    cp -r . $dest/gems/barnes-0.0.9/
    mkdir -p $dest/specifications
    cat > $dest/specifications/barnes-0.0.9.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "barnes"
  s.version = "0.0.9"
  s.summary = "barnes"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
