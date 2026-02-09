#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# method_source 1.1.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "method_source";
  version = "1.1.0";
  src = builtins.path { path = ./source; name = "method_source-1.1.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/method_source-1.1.0
    cp -r . $dest/gems/method_source-1.1.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/method_source-1.1.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "method_source"
  s.version = "1.1.0"
  s.summary = "method_source"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
