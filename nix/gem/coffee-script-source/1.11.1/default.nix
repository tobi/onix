#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# coffee-script-source 1.11.1
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
  pname = "coffee-script-source";
  version = "1.11.1";
  src = builtins.path {
    path = ./source;
    name = "coffee-script-source-1.11.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/coffee-script-source-1.11.1
        cp -r . $dest/gems/coffee-script-source-1.11.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/coffee-script-source-1.11.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "coffee-script-source"
      s.version = "1.11.1"
      s.summary = "coffee-script-source"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
