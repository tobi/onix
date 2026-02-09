#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# graphql-client 0.25.0
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
  pname = "graphql-client";
  version = "0.25.0";
  src = builtins.path {
    path = ./source;
    name = "graphql-client-0.25.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/graphql-client-0.25.0
        cp -r . $dest/gems/graphql-client-0.25.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/graphql-client-0.25.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "graphql-client"
      s.version = "0.25.0"
      s.summary = "graphql-client"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
