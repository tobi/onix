#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# stimulus-rails 1.3.4
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "stimulus-rails";
  version = "1.3.4";
  src = builtins.path { path = ./source; name = "stimulus-rails-1.3.4-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/stimulus-rails-1.3.4
    cp -r . $dest/gems/stimulus-rails-1.3.4/
    mkdir -p $dest/specifications
    cat > $dest/specifications/stimulus-rails-1.3.4.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "stimulus-rails"
  s.version = "1.3.4"
  s.summary = "stimulus-rails"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
