#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# guess_html_encoding 0.0.11
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "guess_html_encoding";
  version = "0.0.11";
  src = builtins.path { path = ./source; name = "guess_html_encoding-0.0.11-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/guess_html_encoding-0.0.11
    cp -r . $dest/gems/guess_html_encoding-0.0.11/
    mkdir -p $dest/specifications
    cat > $dest/specifications/guess_html_encoding-0.0.11.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "guess_html_encoding"
  s.version = "0.0.11"
  s.summary = "guess_html_encoding"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
