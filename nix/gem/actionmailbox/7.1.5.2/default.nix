#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# actionmailbox 7.1.5.2
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "actionmailbox";
  version = "7.1.5.2";
  src = builtins.path {
    path = ./source;
    name = "actionmailbox-7.1.5.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/actionmailbox-7.1.5.2
        cp -r . $dest/gems/actionmailbox-7.1.5.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/actionmailbox-7.1.5.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "actionmailbox"
      s.version = "7.1.5.2"
      s.summary = "actionmailbox"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
