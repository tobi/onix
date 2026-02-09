#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# axe-core-capybara 4.11.1
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
  pname = "axe-core-capybara";
  version = "4.11.1";
  src = builtins.path {
    path = ./source;
    name = "axe-core-capybara-4.11.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/axe-core-capybara-4.11.1
        cp -r . $dest/gems/axe-core-capybara-4.11.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/axe-core-capybara-4.11.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "axe-core-capybara"
      s.version = "4.11.1"
      s.summary = "axe-core-capybara"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
