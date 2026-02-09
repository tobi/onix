#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# factory_bot_rails 6.4.3
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "factory_bot_rails";
  version = "6.4.3";
  src = builtins.path {
    path = ./source;
    name = "factory_bot_rails-6.4.3-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/factory_bot_rails-6.4.3
        cp -r . $dest/gems/factory_bot_rails-6.4.3/
        mkdir -p $dest/specifications
        cat > $dest/specifications/factory_bot_rails-6.4.3.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "factory_bot_rails"
      s.version = "6.4.3"
      s.summary = "factory_bot_rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
