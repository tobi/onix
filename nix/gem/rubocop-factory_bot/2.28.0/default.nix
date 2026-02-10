#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-factory_bot 2.28.0
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
  pname = "rubocop-factory_bot";
  version = "2.28.0";
  src = builtins.path {
    path = ./source;
    name = "rubocop-factory_bot-2.28.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rubocop-factory_bot-2.28.0
        cp -r . $dest/gems/rubocop-factory_bot-2.28.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rubocop-factory_bot-2.28.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rubocop-factory_bot"
      s.version = "2.28.0"
      s.summary = "rubocop-factory_bot"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
