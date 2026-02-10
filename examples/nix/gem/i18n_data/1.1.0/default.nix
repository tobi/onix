#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# i18n_data 1.1.0
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
  pname = "i18n_data";
  version = "1.1.0";
  src = builtins.path {
    path = ./source;
    name = "i18n_data-1.1.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/i18n_data-1.1.0
        cp -r . $dest/gems/i18n_data-1.1.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/i18n_data-1.1.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "i18n_data"
      s.version = "1.1.0"
      s.summary = "i18n_data"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
