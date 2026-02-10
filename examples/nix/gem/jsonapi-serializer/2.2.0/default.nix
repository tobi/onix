#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# jsonapi-serializer 2.2.0
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
  pname = "jsonapi-serializer";
  version = "2.2.0";
  src = builtins.path {
    path = ./source;
    name = "jsonapi-serializer-2.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/jsonapi-serializer-2.2.0
        cp -r . $dest/gems/jsonapi-serializer-2.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/jsonapi-serializer-2.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "jsonapi-serializer"
      s.version = "2.2.0"
      s.summary = "jsonapi-serializer"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
