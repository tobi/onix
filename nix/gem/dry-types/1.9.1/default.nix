#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# dry-types 1.9.1
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
  pname = "dry-types";
  version = "1.9.1";
  src = builtins.path {
    path = ./source;
    name = "dry-types-1.9.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/dry-types-1.9.1
        cp -r . $dest/gems/dry-types-1.9.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/dry-types-1.9.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "dry-types"
      s.version = "1.9.1"
      s.summary = "dry-types"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
