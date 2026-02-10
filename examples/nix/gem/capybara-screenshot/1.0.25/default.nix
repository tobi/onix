#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# capybara-screenshot 1.0.25
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
  pname = "capybara-screenshot";
  version = "1.0.25";
  src = builtins.path {
    path = ./source;
    name = "capybara-screenshot-1.0.25-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/capybara-screenshot-1.0.25
        cp -r . $dest/gems/capybara-screenshot-1.0.25/
        mkdir -p $dest/specifications
        cat > $dest/specifications/capybara-screenshot-1.0.25.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "capybara-screenshot"
      s.version = "1.0.25"
      s.summary = "capybara-screenshot"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
