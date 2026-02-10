#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# recaptcha 5.21.1
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
  pname = "recaptcha";
  version = "5.21.1";
  src = builtins.path {
    path = ./source;
    name = "recaptcha-5.21.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/recaptcha-5.21.1
        cp -r . $dest/gems/recaptcha-5.21.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/recaptcha-5.21.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "recaptcha"
      s.version = "5.21.1"
      s.summary = "recaptcha"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
