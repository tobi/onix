#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# doorkeeper-i18n 5.2.8
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
  pname = "doorkeeper-i18n";
  version = "5.2.8";
  src = builtins.path {
    path = ./source;
    name = "doorkeeper-i18n-5.2.8-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/doorkeeper-i18n-5.2.8
        cp -r . $dest/gems/doorkeeper-i18n-5.2.8/
        mkdir -p $dest/specifications
        cat > $dest/specifications/doorkeeper-i18n-5.2.8.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "doorkeeper-i18n"
      s.version = "5.2.8"
      s.summary = "doorkeeper-i18n"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
