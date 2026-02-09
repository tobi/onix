#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# prettier_print 1.2.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "prettier_print";
  version = "1.2.1";
  src = builtins.path { path = ./source; name = "prettier_print-1.2.1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/prettier_print-1.2.1
    cp -r . $dest/gems/prettier_print-1.2.1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/prettier_print-1.2.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "prettier_print"
  s.version = "1.2.1"
  s.summary = "prettier_print"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
