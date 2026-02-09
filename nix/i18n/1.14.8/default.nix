#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# i18n 1.14.8
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "i18n";
  version = "1.14.8";
  src = builtins.path { path = ./source; name = "i18n-1.14.8-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/i18n-1.14.8
    cp -r . $dest/gems/i18n-1.14.8/
    mkdir -p $dest/specifications
    cat > $dest/specifications/i18n-1.14.8.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "i18n"
  s.version = "1.14.8"
  s.summary = "i18n"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
