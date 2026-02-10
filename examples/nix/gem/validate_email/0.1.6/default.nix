#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# validate_email 0.1.6
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
  pname = "validate_email";
  version = "0.1.6";
  src = builtins.path {
    path = ./source;
    name = "validate_email-0.1.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/validate_email-0.1.6
        cp -r . $dest/gems/validate_email-0.1.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/validate_email-0.1.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "validate_email"
      s.version = "0.1.6"
      s.summary = "validate_email"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
