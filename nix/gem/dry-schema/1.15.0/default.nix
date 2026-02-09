#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dry-schema 1.15.0
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
  pname = "dry-schema";
  version = "1.15.0";
  src = builtins.path {
    path = ./source;
    name = "dry-schema-1.15.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/dry-schema-1.15.0
        cp -r . $dest/gems/dry-schema-1.15.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/dry-schema-1.15.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "dry-schema"
      s.version = "1.15.0"
      s.summary = "dry-schema"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
