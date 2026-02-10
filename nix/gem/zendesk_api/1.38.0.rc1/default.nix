#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# zendesk_api 1.38.0.rc1
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
  pname = "zendesk_api";
  version = "1.38.0.rc1";
  src = builtins.path {
    path = ./source;
    name = "zendesk_api-1.38.0.rc1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/zendesk_api-1.38.0.rc1
        cp -r . $dest/gems/zendesk_api-1.38.0.rc1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/zendesk_api-1.38.0.rc1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "zendesk_api"
      s.version = "1.38.0.rc1"
      s.summary = "zendesk_api"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
