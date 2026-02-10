#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# i18n-js 3.9.2
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
  pname = "i18n-js";
  version = "3.9.2";
  src = builtins.path {
    path = ./source;
    name = "i18n-js-3.9.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/i18n-js-3.9.2
        cp -r . $dest/gems/i18n-js-3.9.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/i18n-js-3.9.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "i18n-js"
      s.version = "3.9.2"
      s.summary = "i18n-js"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
