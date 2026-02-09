#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rails_failover 2.3.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "rails_failover";
  version = "2.3.0";
  src = builtins.path { path = ./source; name = "rails_failover-2.3.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/rails_failover-2.3.0
    cp -r . $dest/gems/rails_failover-2.3.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/rails_failover-2.3.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "rails_failover"
  s.version = "2.3.0"
  s.summary = "rails_failover"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
