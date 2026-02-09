#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# database_cleaner-active_record 2.1.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "database_cleaner-active_record";
  version = "2.1.0";
  src = builtins.path { path = ./source; name = "database_cleaner-active_record-2.1.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/database_cleaner-active_record-2.1.0
    cp -r . $dest/gems/database_cleaner-active_record-2.1.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/database_cleaner-active_record-2.1.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "database_cleaner-active_record"
  s.version = "2.1.0"
  s.summary = "database_cleaner-active_record"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
