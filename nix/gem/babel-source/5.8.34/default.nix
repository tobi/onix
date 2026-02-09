#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# babel-source 5.8.34
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
  pname = "babel-source";
  version = "5.8.34";
  src = builtins.path {
    path = ./source;
    name = "babel-source-5.8.34-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/babel-source-5.8.34
        cp -r . $dest/gems/babel-source-5.8.34/
        mkdir -p $dest/specifications
        cat > $dest/specifications/babel-source-5.8.34.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "babel-source"
      s.version = "5.8.34"
      s.summary = "babel-source"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
