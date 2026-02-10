#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# factory_bot_rails 6.4.4
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
  pname = "factory_bot_rails";
  version = "6.4.4";
  src = builtins.path {
    path = ./source;
    name = "factory_bot_rails-6.4.4-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/factory_bot_rails-6.4.4
        cp -r . $dest/gems/factory_bot_rails-6.4.4/
        mkdir -p $dest/specifications
        cat > $dest/specifications/factory_bot_rails-6.4.4.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "factory_bot_rails"
      s.version = "6.4.4"
      s.summary = "factory_bot_rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
