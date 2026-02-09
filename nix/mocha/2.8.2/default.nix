#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mocha 2.8.2
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "mocha";
  version = "2.8.2";
  src = builtins.path { path = ./source; name = "mocha-2.8.2-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/mocha-2.8.2
    cp -r . $dest/gems/mocha-2.8.2/
    mkdir -p $dest/specifications
    cat > $dest/specifications/mocha-2.8.2.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "mocha"
  s.version = "2.8.2"
  s.summary = "mocha"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
