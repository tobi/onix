#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# kaminari-actionview 1.2.2
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "kaminari-actionview";
  version = "1.2.2";
  src = builtins.path { path = ./source; name = "kaminari-actionview-1.2.2-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/kaminari-actionview-1.2.2
    cp -r . $dest/gems/kaminari-actionview-1.2.2/
    mkdir -p $dest/specifications
    cat > $dest/specifications/kaminari-actionview-1.2.2.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "kaminari-actionview"
  s.version = "1.2.2"
  s.summary = "kaminari-actionview"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
