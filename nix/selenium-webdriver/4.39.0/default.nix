#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# selenium-webdriver 4.39.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "selenium-webdriver";
  version = "4.39.0";
  src = builtins.path { path = ./source; name = "selenium-webdriver-4.39.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/selenium-webdriver-4.39.0
    cp -r . $dest/gems/selenium-webdriver-4.39.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/selenium-webdriver-4.39.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "selenium-webdriver"
  s.version = "4.39.0"
  s.summary = "selenium-webdriver"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
