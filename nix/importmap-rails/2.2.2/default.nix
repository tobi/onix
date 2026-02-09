#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# importmap-rails 2.2.2
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "importmap-rails";
  version = "2.2.2";
  src = builtins.path { path = ./source; name = "importmap-rails-2.2.2-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/importmap-rails-2.2.2
    cp -r . $dest/gems/importmap-rails-2.2.2/
    mkdir -p $dest/specifications
    cat > $dest/specifications/importmap-rails-2.2.2.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "importmap-rails"
  s.version = "2.2.2"
  s.summary = "importmap-rails"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
