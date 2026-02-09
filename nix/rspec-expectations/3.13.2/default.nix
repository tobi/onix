#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-expectations 3.13.2
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "rspec-expectations";
  version = "3.13.2";
  src = builtins.path { path = ./source; name = "rspec-expectations-3.13.2-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/rspec-expectations-3.13.2
    cp -r . $dest/gems/rspec-expectations-3.13.2/
    mkdir -p $dest/specifications
    cat > $dest/specifications/rspec-expectations-3.13.2.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "rspec-expectations"
  s.version = "3.13.2"
  s.summary = "rspec-expectations"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
