#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# graphql 2.5.19
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
  version = "2.5.19";
  src = builtins.path {
    path = ./source;
    name = "graphql-2.5.19-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/graphql-2.5.19
        cp -r . $dest/gems/graphql-2.5.19/
        mkdir -p $dest/specifications
        cat > $dest/specifications/graphql-2.5.19.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "graphql"
      s.version = "2.5.19"
      s.summary = "graphql"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
