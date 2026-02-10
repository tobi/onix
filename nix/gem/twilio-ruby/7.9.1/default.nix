#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# twilio-ruby 7.9.1
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
  pname = "twilio-ruby";
  version = "7.9.1";
  src = builtins.path {
    path = ./source;
    name = "twilio-ruby-7.9.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/twilio-ruby-7.9.1
        cp -r . $dest/gems/twilio-ruby-7.9.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/twilio-ruby-7.9.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "twilio-ruby"
      s.version = "7.9.1"
      s.summary = "twilio-ruby"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
