#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# json_refs 0.1.8
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "json_refs";
  version = "0.1.8";
  src = builtins.path { path = ./source; name = "json_refs-0.1.8-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/json_refs-0.1.8
    cp -r . $dest/gems/json_refs-0.1.8/
    mkdir -p $dest/specifications
    cat > $dest/specifications/json_refs-0.1.8.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "json_refs"
  s.version = "0.1.8"
  s.summary = "json_refs"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
