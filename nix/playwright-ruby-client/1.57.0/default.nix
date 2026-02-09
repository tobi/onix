#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# playwright-ruby-client 1.57.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "playwright-ruby-client";
  version = "1.57.0";
  src = builtins.path { path = ./source; name = "playwright-ruby-client-1.57.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/playwright-ruby-client-1.57.0
    cp -r . $dest/gems/playwright-ruby-client-1.57.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/playwright-ruby-client-1.57.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "playwright-ruby-client"
  s.version = "1.57.0"
  s.summary = "playwright-ruby-client"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
