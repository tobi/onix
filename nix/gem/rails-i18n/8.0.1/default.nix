#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rails-i18n 8.0.1
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
  pname = "rails-i18n";
  version = "8.0.1";
  src = builtins.path {
    path = ./source;
    name = "rails-i18n-8.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rails-i18n-8.0.1
        cp -r . $dest/gems/rails-i18n-8.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rails-i18n-8.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rails-i18n"
      s.version = "8.0.1"
      s.summary = "rails-i18n"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
