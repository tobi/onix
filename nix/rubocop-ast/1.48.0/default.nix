#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-ast 1.48.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "rubocop-ast";
  version = "1.48.0";
  src = builtins.path { path = ./source; name = "rubocop-ast-1.48.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/rubocop-ast-1.48.0
    cp -r . $dest/gems/rubocop-ast-1.48.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/rubocop-ast-1.48.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "rubocop-ast"
  s.version = "1.48.0"
  s.summary = "rubocop-ast"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
