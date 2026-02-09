#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ostruct 0.6.3
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "ostruct";
  version = "0.6.3";
  src = builtins.path { path = ./source; name = "ostruct-0.6.3-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/ostruct-0.6.3
    cp -r . $dest/gems/ostruct-0.6.3/
    mkdir -p $dest/specifications
    cat > $dest/specifications/ostruct-0.6.3.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "ostruct"
  s.version = "0.6.3"
  s.summary = "ostruct"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
