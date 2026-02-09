#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# cocoapods-core 1.16.0
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
  pname = "cocoapods-core";
  version = "1.16.0";
  src = builtins.path {
    path = ./source;
    name = "cocoapods-core-1.16.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/cocoapods-core-1.16.0
        cp -r . $dest/gems/cocoapods-core-1.16.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/cocoapods-core-1.16.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "cocoapods-core"
      s.version = "1.16.0"
      s.summary = "cocoapods-core"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
