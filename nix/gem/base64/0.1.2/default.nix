#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# base64 0.1.2
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
  pname = "base64";
  version = "0.1.2";
  src = builtins.path {
    path = ./source;
    name = "base64-0.1.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/base64-0.1.2
        cp -r . $dest/gems/base64-0.1.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/base64-0.1.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "base64"
      s.version = "0.1.2"
      s.summary = "base64"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
