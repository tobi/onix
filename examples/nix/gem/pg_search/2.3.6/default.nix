#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# pg_search 2.3.6
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
  pname = "pg_search";
  version = "2.3.6";
  src = builtins.path {
    path = ./source;
    name = "pg_search-2.3.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/pg_search-2.3.6
        cp -r . $dest/gems/pg_search-2.3.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/pg_search-2.3.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "pg_search"
      s.version = "2.3.6"
      s.summary = "pg_search"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
