#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# minitest 5.26.2
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "minitest";
  version = "5.26.2";
  src = builtins.path { path = ./source; name = "minitest-5.26.2-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/minitest-5.26.2
    cp -r . $dest/gems/minitest-5.26.2/
    mkdir -p $dest/specifications
    cat > $dest/specifications/minitest-5.26.2.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "minitest"
  s.version = "5.26.2"
  s.summary = "minitest"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
