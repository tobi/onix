#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# gapic-common 1.0.1
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
  pname = "gapic-common";
  version = "1.0.1";
  src = builtins.path {
    path = ./source;
    name = "gapic-common-1.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/gapic-common-1.0.1
        cp -r . $dest/gems/gapic-common-1.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/gapic-common-1.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "gapic-common"
      s.version = "1.0.1"
      s.summary = "gapic-common"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
