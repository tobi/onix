#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# sassc-embedded 1.80.5
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "sassc-embedded";
  version = "1.80.5";
  src = builtins.path { path = ./source; name = "sassc-embedded-1.80.5-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/sassc-embedded-1.80.5
    cp -r . $dest/gems/sassc-embedded-1.80.5/
    mkdir -p $dest/specifications
    cat > $dest/specifications/sassc-embedded-1.80.5.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "sassc-embedded"
  s.version = "1.80.5"
  s.summary = "sassc-embedded"
  s.require_paths = ["lib", "vendor/github.com/sass/sassc-ruby/lib"]
  s.files = []
end
EOF
  '';
}
