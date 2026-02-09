#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# strong_migrations 2.5.1
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
  pname = "strong_migrations";
  version = "2.5.1";
  src = builtins.path {
    path = ./source;
    name = "strong_migrations-2.5.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/strong_migrations-2.5.1
        cp -r . $dest/gems/strong_migrations-2.5.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/strong_migrations-2.5.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "strong_migrations"
      s.version = "2.5.1"
      s.summary = "strong_migrations"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
