#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# css_parser 1.21.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "css_parser";
  version = "1.21.1";
  src = builtins.path { path = ./source; name = "css_parser-1.21.1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/css_parser-1.21.1
    cp -r . $dest/gems/css_parser-1.21.1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/css_parser-1.21.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "css_parser"
  s.version = "1.21.1"
  s.summary = "css_parser"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
