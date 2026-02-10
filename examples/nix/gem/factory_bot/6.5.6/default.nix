#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# factory_bot 6.5.6
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
  pname = "factory_bot";
  version = "6.5.6";
  src = builtins.path {
    path = ./source;
    name = "factory_bot-6.5.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/factory_bot-6.5.6
        cp -r . $dest/gems/factory_bot-6.5.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/factory_bot-6.5.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "factory_bot"
      s.version = "6.5.6"
      s.summary = "factory_bot"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
