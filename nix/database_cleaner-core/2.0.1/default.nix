#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# database_cleaner-core 2.0.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "database_cleaner-core";
  version = "2.0.1";
  src = builtins.path { path = ./source; name = "database_cleaner-core-2.0.1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/database_cleaner-core-2.0.1
    cp -r . $dest/gems/database_cleaner-core-2.0.1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/database_cleaner-core-2.0.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "database_cleaner-core"
  s.version = "2.0.1"
  s.summary = "database_cleaner-core"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
