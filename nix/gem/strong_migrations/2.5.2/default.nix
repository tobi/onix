#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# strong_migrations 2.5.2
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
  version = "2.5.2";
  src = builtins.path {
    path = ./source;
    name = "strong_migrations-2.5.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/strong_migrations-2.5.2
        cp -r . $dest/gems/strong_migrations-2.5.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/strong_migrations-2.5.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "strong_migrations"
      s.version = "2.5.2"
      s.summary = "strong_migrations"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
