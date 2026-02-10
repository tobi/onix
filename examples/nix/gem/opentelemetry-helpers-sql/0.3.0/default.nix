#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# opentelemetry-helpers-sql 0.3.0
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
  pname = "opentelemetry-helpers-sql";
  version = "0.3.0";
  src = builtins.path {
    path = ./source;
    name = "opentelemetry-helpers-sql-0.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/opentelemetry-helpers-sql-0.3.0
        cp -r . $dest/gems/opentelemetry-helpers-sql-0.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/opentelemetry-helpers-sql-0.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "opentelemetry-helpers-sql"
      s.version = "0.3.0"
      s.summary = "opentelemetry-helpers-sql"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
