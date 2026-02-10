#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# email_validator 2.2.4
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
  pname = "email_validator";
  version = "2.2.4";
  src = builtins.path {
    path = ./source;
    name = "email_validator-2.2.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/email_validator-2.2.4
        cp -r . $dest/gems/email_validator-2.2.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/email_validator-2.2.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "email_validator"
      s.version = "2.2.4"
      s.summary = "email_validator"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
