#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# factory_girl_rails 4.8.0
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
  pname = "factory_girl_rails";
  version = "4.8.0";
  src = builtins.path {
    path = ./source;
    name = "factory_girl_rails-4.8.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/factory_girl_rails-4.8.0
        cp -r . $dest/gems/factory_girl_rails-4.8.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/factory_girl_rails-4.8.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "factory_girl_rails"
      s.version = "4.8.0"
      s.summary = "factory_girl_rails"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
