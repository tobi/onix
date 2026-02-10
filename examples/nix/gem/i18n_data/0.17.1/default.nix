#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# i18n_data 0.17.1
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
  version = "0.17.1";
  src = builtins.path {
    path = ./source;
    name = "i18n_data-0.17.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/i18n_data-0.17.1
        cp -r . $dest/gems/i18n_data-0.17.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/i18n_data-0.17.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "i18n_data"
      s.version = "0.17.1"
      s.summary = "i18n_data"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
