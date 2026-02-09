#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-rails 8.0.2
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "rspec-rails";
  version = "8.0.2";
  src = builtins.path { path = ./source; name = "rspec-rails-8.0.2-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/rspec-rails-8.0.2
    cp -r . $dest/gems/rspec-rails-8.0.2/
    mkdir -p $dest/specifications
    cat > $dest/specifications/rspec-rails-8.0.2.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "rspec-rails"
  s.version = "8.0.2"
  s.summary = "rspec-rails"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
