#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# newrelic-sidekiq-metrics 1.6.2
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "newrelic-sidekiq-metrics";
  version = "1.6.2";
  src = builtins.path { path = ./source; name = "newrelic-sidekiq-metrics-1.6.2-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/newrelic-sidekiq-metrics-1.6.2
    cp -r . $dest/gems/newrelic-sidekiq-metrics-1.6.2/
    mkdir -p $dest/specifications
    cat > $dest/specifications/newrelic-sidekiq-metrics-1.6.2.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "newrelic-sidekiq-metrics"
  s.version = "1.6.2"
  s.summary = "newrelic-sidekiq-metrics"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
