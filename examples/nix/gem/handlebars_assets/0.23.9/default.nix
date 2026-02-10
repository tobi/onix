#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# handlebars_assets 0.23.9
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
  pname = "handlebars_assets";
  version = "0.23.9";
  src = builtins.path {
    path = ./source;
    name = "handlebars_assets-0.23.9-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/handlebars_assets-0.23.9
        cp -r . $dest/gems/handlebars_assets-0.23.9/
        mkdir -p $dest/specifications
        cat > $dest/specifications/handlebars_assets-0.23.9.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "handlebars_assets"
      s.version = "0.23.9"
      s.summary = "handlebars_assets"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
