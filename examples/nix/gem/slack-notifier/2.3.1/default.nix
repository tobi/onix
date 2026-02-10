#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# slack-notifier 2.3.1
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
  pname = "slack-notifier";
  version = "2.3.1";
  src = builtins.path {
    path = ./source;
    name = "slack-notifier-2.3.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/slack-notifier-2.3.1
        cp -r . $dest/gems/slack-notifier-2.3.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/slack-notifier-2.3.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "slack-notifier"
      s.version = "2.3.1"
      s.summary = "slack-notifier"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
