#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# database_cleaner-active_record 2.2.2
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
  pname = "database_cleaner-active_record";
  version = "2.2.2";
  src = builtins.path {
    path = ./source;
    name = "database_cleaner-active_record-2.2.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/database_cleaner-active_record-2.2.2
        cp -r . $dest/gems/database_cleaner-active_record-2.2.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/database_cleaner-active_record-2.2.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "database_cleaner-active_record"
      s.version = "2.2.2"
      s.summary = "database_cleaner-active_record"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
