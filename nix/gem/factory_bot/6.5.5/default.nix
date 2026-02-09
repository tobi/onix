#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# factory_bot 6.5.5
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
  version = "6.5.5";
  src = builtins.path {
    path = ./source;
    name = "factory_bot-6.5.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/factory_bot-6.5.5
        cp -r . $dest/gems/factory_bot-6.5.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/factory_bot-6.5.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "factory_bot"
      s.version = "6.5.5"
      s.summary = "factory_bot"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
