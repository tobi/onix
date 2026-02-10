#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# aws-actionmailbox-ses 0.1.0
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
  pname = "aws-actionmailbox-ses";
  version = "0.1.0";
  src = builtins.path {
    path = ./source;
    name = "aws-actionmailbox-ses-0.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/aws-actionmailbox-ses-0.1.0
        cp -r . $dest/gems/aws-actionmailbox-ses-0.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/aws-actionmailbox-ses-0.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "aws-actionmailbox-ses"
      s.version = "0.1.0"
      s.summary = "aws-actionmailbox-ses"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
