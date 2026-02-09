#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# procore-sift 1.0.0
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "procore-sift";
  version = "1.0.0";
  src = builtins.path {
    path = ./source;
    name = "procore-sift-1.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/procore-sift-1.0.0
        cp -r . $dest/gems/procore-sift-1.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/procore-sift-1.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "procore-sift"
      s.version = "1.0.0"
      s.summary = "procore-sift"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
