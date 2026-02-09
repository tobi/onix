#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dotenv-rails 3.1.2
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "dotenv-rails";
  version = "3.1.2";
  src = builtins.path { path = ./source; name = "dotenv-rails-3.1.2-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/dotenv-rails-3.1.2
    cp -r . $dest/gems/dotenv-rails-3.1.2/
    mkdir -p $dest/specifications
    cat > $dest/specifications/dotenv-rails-3.1.2.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "dotenv-rails"
  s.version = "3.1.2"
  s.summary = "dotenv-rails"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
