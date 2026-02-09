#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ttfunk 1.8.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "ttfunk";
  version = "1.8.0";
  src = builtins.path { path = ./source; name = "ttfunk-1.8.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/ttfunk-1.8.0
    cp -r . $dest/gems/ttfunk-1.8.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/ttfunk-1.8.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "ttfunk"
  s.version = "1.8.0"
  s.summary = "ttfunk"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
