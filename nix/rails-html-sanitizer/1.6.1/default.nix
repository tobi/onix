#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rails-html-sanitizer 1.6.1
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "rails-html-sanitizer";
  version = "1.6.1";
  src = builtins.path { path = ./source; name = "rails-html-sanitizer-1.6.1-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/rails-html-sanitizer-1.6.1
    cp -r . $dest/gems/rails-html-sanitizer-1.6.1/
    mkdir -p $dest/specifications
    cat > $dest/specifications/rails-html-sanitizer-1.6.1.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "rails-html-sanitizer"
  s.version = "1.6.1"
  s.summary = "rails-html-sanitizer"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
