#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# i18n 1.14.6
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
  pname = "i18n";
  version = "1.14.6";
  src = builtins.path {
    path = ./source;
    name = "i18n-1.14.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/i18n-1.14.6
        cp -r . $dest/gems/i18n-1.14.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/i18n-1.14.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "i18n"
      s.version = "1.14.6"
      s.summary = "i18n"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
