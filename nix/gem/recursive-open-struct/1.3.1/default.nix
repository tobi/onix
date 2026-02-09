#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# recursive-open-struct 1.3.1
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
  pname = "recursive-open-struct";
  version = "1.3.1";
  src = builtins.path {
    path = ./source;
    name = "recursive-open-struct-1.3.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/recursive-open-struct-1.3.1
        cp -r . $dest/gems/recursive-open-struct-1.3.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/recursive-open-struct-1.3.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "recursive-open-struct"
      s.version = "1.3.1"
      s.summary = "recursive-open-struct"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
