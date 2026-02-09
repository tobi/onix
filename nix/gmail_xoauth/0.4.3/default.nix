#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gmail_xoauth 0.4.3
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "gmail_xoauth";
  version = "0.4.3";
  src = builtins.path { path = ./source; name = "gmail_xoauth-0.4.3-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/gmail_xoauth-0.4.3
    cp -r . $dest/gems/gmail_xoauth-0.4.3/
    mkdir -p $dest/specifications
    cat > $dest/specifications/gmail_xoauth-0.4.3.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "gmail_xoauth"
  s.version = "0.4.3"
  s.summary = "gmail_xoauth"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
