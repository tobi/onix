#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# simple-navigation 4.4.1
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
  pname = "simple-navigation";
  version = "4.4.1";
  src = builtins.path {
    path = ./source;
    name = "simple-navigation-4.4.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/simple-navigation-4.4.1
        cp -r . $dest/gems/simple-navigation-4.4.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/simple-navigation-4.4.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "simple-navigation"
      s.version = "4.4.1"
      s.summary = "simple-navigation"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
