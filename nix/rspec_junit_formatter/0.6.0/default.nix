#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec_junit_formatter 0.6.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "rspec_junit_formatter";
  version = "0.6.0";
  src = builtins.path { path = ./source; name = "rspec_junit_formatter-0.6.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/rspec_junit_formatter-0.6.0
    cp -r . $dest/gems/rspec_junit_formatter-0.6.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/rspec_junit_formatter-0.6.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "rspec_junit_formatter"
  s.version = "0.6.0"
  s.summary = "rspec_junit_formatter"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
