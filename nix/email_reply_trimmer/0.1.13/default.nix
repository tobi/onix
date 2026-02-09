#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# email_reply_trimmer 0.1.13
#
{ lib, stdenv, ruby }:

let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in

stdenv.mkDerivation {
  pname = "email_reply_trimmer";
  version = "0.1.13";
  src = builtins.path { path = ./source; name = "email_reply_trimmer-0.1.13-source"; };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
    local dest=$out/${prefix}
    mkdir -p $dest/gems/email_reply_trimmer-0.1.13
    cp -r . $dest/gems/email_reply_trimmer-0.1.13/
    mkdir -p $dest/specifications
    cat > $dest/specifications/email_reply_trimmer-0.1.13.gemspec <<'EOF'
Gem::Specification.new do |s|
  s.name = "email_reply_trimmer"
  s.version = "0.1.13"
  s.summary = "email_reply_trimmer"
  s.require_paths = ["lib"]
  s.files = []
end
EOF
  '';
}
