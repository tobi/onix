#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# groupdate 6.2.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "groupdate";
  version = "6.2.1";
  src = builtins.path { path = ./source; name = "groupdate-6.2.1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/groupdate-6.2.1
    cp -r . $dest/gems/groupdate-6.2.1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/groupdate-6.2.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "groupdate"
  s.version = "6.2.1"
  s.summary = "groupdate"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
