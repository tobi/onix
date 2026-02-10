#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-i18n 3.2.3
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
  pname = "rubocop-i18n";
  version = "3.2.3";
  src = builtins.path {
    path = ./source;
    name = "rubocop-i18n-3.2.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rubocop-i18n-3.2.3
        cp -r . $dest/gems/rubocop-i18n-3.2.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rubocop-i18n-3.2.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rubocop-i18n"
      s.version = "3.2.3"
      s.summary = "rubocop-i18n"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
