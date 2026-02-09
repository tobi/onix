#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# fuubar 2.4.1
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
  pname = "fuubar";
  version = "2.4.1";
  src = builtins.path {
    path = ./source;
    name = "fuubar-2.4.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/fuubar-2.4.1
        cp -r . $dest/gems/fuubar-2.4.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/fuubar-2.4.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "fuubar"
      s.version = "2.4.1"
      s.summary = "fuubar"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
