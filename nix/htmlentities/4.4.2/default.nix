#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# htmlentities 4.4.2
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "htmlentities";
  version = "4.4.2";
  src = builtins.path { path = ./source; name = "htmlentities-4.4.2-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/htmlentities-4.4.2
    cp -r . $dest/gems/htmlentities-4.4.2/
    mkdir -p $dest/specifications
    cat > $dest/specifications/htmlentities-4.4.2.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "htmlentities"
  s.version = "4.4.2"
  s.summary = "htmlentities"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
