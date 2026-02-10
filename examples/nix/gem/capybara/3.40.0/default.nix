#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# capybara 3.40.0
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
  pname = "capybara";
  version = "3.40.0";
  src = builtins.path {
    path = ./source;
    name = "capybara-3.40.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/capybara-3.40.0
        cp -r . $dest/gems/capybara-3.40.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/capybara-3.40.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "capybara"
      s.version = "3.40.0"
      s.summary = "capybara"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
