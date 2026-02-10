#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# actionmailbox 7.0.8.7
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
  version = "7.0.8.7";
  src = builtins.path {
    path = ./source;
    name = "actionmailbox-7.0.8.7-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/actionmailbox-7.0.8.7
        cp -r . $dest/gems/actionmailbox-7.0.8.7/
        mkdir -p $dest/specifications
        cat > $dest/specifications/actionmailbox-7.0.8.7.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "actionmailbox"
      s.version = "7.0.8.7"
      s.summary = "actionmailbox"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
