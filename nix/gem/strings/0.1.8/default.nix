#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# strings 0.1.8
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
  pname = "strings";
  version = "0.1.8";
  src = builtins.path {
    path = ./source;
    name = "strings-0.1.8-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/strings-0.1.8
        cp -r . $dest/gems/strings-0.1.8/
        mkdir -p $dest/specifications
        cat > $dest/specifications/strings-0.1.8.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "strings"
      s.version = "0.1.8"
      s.summary = "strings"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
