#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-support 3.13.6
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "rspec-support";
  version = "3.13.6";
  src = builtins.path { path = ./source; name = "rspec-support-3.13.6-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/rspec-support-3.13.6
    cp -r . $dest/gems/rspec-support-3.13.6/
    mkdir -p $dest/specifications
    cat > $dest/specifications/rspec-support-3.13.6.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "rspec-support"
  s.version = "3.13.6"
  s.summary = "rspec-support"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
