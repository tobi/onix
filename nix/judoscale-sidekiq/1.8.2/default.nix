#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# judoscale-sidekiq 1.8.2
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "judoscale-sidekiq";
  version = "1.8.2";
  src = builtins.path { path = ./source; name = "judoscale-sidekiq-1.8.2-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/judoscale-sidekiq-1.8.2
    cp -r . $dest/gems/judoscale-sidekiq-1.8.2/
    mkdir -p $dest/specifications
    cat > $dest/specifications/judoscale-sidekiq-1.8.2.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "judoscale-sidekiq"
  s.version = "1.8.2"
  s.summary = "judoscale-sidekiq"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
