#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mini_sql 1.6.0
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
  pname = "mini_sql";
  version = "1.6.0";
  src = builtins.path {
    path = ./source;
    name = "mini_sql-1.6.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/mini_sql-1.6.0
        cp -r . $dest/gems/mini_sql-1.6.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mini_sql-1.6.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mini_sql"
      s.version = "1.6.0"
      s.summary = "mini_sql"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
