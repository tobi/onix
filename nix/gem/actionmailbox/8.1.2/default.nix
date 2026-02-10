#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# actionmailbox 8.1.2
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  bundle_path = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "actionmailbox";
  version = "8.1.2";
  src = builtins.path {
    path = ./source;
    name = "actionmailbox-8.1.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/actionmailbox-8.1.2
        cp -r . $dest/gems/actionmailbox-8.1.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/actionmailbox-8.1.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "actionmailbox"
      s.version = "8.1.2"
      s.summary = "actionmailbox"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
