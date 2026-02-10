#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# json-schema 5.2.2
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
  version = "5.2.2";
  src = builtins.path {
    path = ./source;
    name = "json-schema-5.2.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/json-schema-5.2.2
        cp -r . $dest/gems/json-schema-5.2.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/json-schema-5.2.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "json-schema"
      s.version = "5.2.2"
      s.summary = "json-schema"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
