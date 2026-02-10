#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# rubocop-capybara 2.20.0
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
  pname = "rubocop-capybara";
  version = "2.20.0";
  src = builtins.path {
    path = ./source;
    name = "rubocop-capybara-2.20.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/rubocop-capybara-2.20.0
        cp -r . $dest/gems/rubocop-capybara-2.20.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/rubocop-capybara-2.20.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "rubocop-capybara"
      s.version = "2.20.0"
      s.summary = "rubocop-capybara"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
