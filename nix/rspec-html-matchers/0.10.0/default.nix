#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rspec-html-matchers 0.10.0
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "rspec-html-matchers";
  version = "0.10.0";
  src = builtins.path { path = ./source; name = "rspec-html-matchers-0.10.0-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/rspec-html-matchers-0.10.0
    cp -r . $dest/gems/rspec-html-matchers-0.10.0/
    mkdir -p $dest/specifications
    cat > $dest/specifications/rspec-html-matchers-0.10.0.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "rspec-html-matchers"
  s.version = "0.10.0"
  s.summary = "rspec-html-matchers"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
