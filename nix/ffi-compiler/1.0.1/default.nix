#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# ffi-compiler 1.0.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "ffi-compiler";
  version = "1.0.1";
  src = builtins.path { path = ./source; name = "ffi-compiler-1.0.1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/ffi-compiler-1.0.1
    cp -r . $dest/gems/ffi-compiler-1.0.1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/ffi-compiler-1.0.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "ffi-compiler"
  s.version = "1.0.1"
  s.summary = "ffi-compiler"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
