#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# json-schema 6.0.0
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
  pname = "json-schema";
  version = "6.0.0";
  src = builtins.path {
    path = ./source;
    name = "json-schema-6.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/json-schema-6.0.0
        cp -r . $dest/gems/json-schema-6.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/json-schema-6.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "json-schema"
      s.version = "6.0.0"
      s.summary = "json-schema"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
