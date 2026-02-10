#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# shopify_api 14.8.0
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
  pname = "shopify_api";
  version = "14.8.0";
  src = builtins.path {
    path = ./source;
    name = "shopify_api-14.8.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/shopify_api-14.8.0
        cp -r . $dest/gems/shopify_api-14.8.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/shopify_api-14.8.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "shopify_api"
      s.version = "14.8.0"
      s.summary = "shopify_api"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
