#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# oauth2 2.0.16
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
  pname = "oauth2";
  version = "2.0.16";
  src = builtins.path {
    path = ./source;
    name = "oauth2-2.0.16-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/oauth2-2.0.16
        cp -r . $dest/gems/oauth2-2.0.16/
        mkdir -p $dest/specifications
        cat > $dest/specifications/oauth2-2.0.16.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "oauth2"
      s.version = "2.0.16"
      s.summary = "oauth2"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
