#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# graphql 2.5.18
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
  pname = "graphql";
  version = "2.5.18";
  src = builtins.path {
    path = ./source;
    name = "graphql-2.5.18-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/graphql-2.5.18
        cp -r . $dest/gems/graphql-2.5.18/
        mkdir -p $dest/specifications
        cat > $dest/specifications/graphql-2.5.18.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "graphql"
      s.version = "2.5.18"
      s.summary = "graphql"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
