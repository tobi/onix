#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# selenium-webdriver 4.40.0
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
  pname = "selenium-webdriver";
  version = "4.40.0";
  src = builtins.path {
    path = ./source;
    name = "selenium-webdriver-4.40.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/selenium-webdriver-4.40.0
        cp -r . $dest/gems/selenium-webdriver-4.40.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/selenium-webdriver-4.40.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "selenium-webdriver"
      s.version = "4.40.0"
      s.summary = "selenium-webdriver"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
