#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# email-provider-info 0.0.1
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
  pname = "email-provider-info";
  version = "0.0.1";
  src = builtins.path {
    path = ./source;
    name = "email-provider-info-0.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/email-provider-info-0.0.1
        cp -r . $dest/gems/email-provider-info-0.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/email-provider-info-0.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "email-provider-info"
      s.version = "0.0.1"
      s.summary = "email-provider-info"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
