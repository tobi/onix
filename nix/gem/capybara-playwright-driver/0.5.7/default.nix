#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# capybara-playwright-driver 0.5.7
#
{
  lib,
  stdenv,
  ruby,
}:
let
  rubyVersion = "${ruby.version.majMin}.0";
  arch = stdenv.hostPlatform.system;
  prefix = "ruby/${rubyVersion}";
in
stdenv.mkDerivation {
  pname = "capybara-playwright-driver";
  version = "0.5.7";
  src = builtins.path {
    path = ./source;
    name = "capybara-playwright-driver-0.5.7-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit prefix; };

  installPhase = ''
        local dest=$out/${prefix}
        mkdir -p $dest/gems/capybara-playwright-driver-0.5.7
        cp -r . $dest/gems/capybara-playwright-driver-0.5.7/
        mkdir -p $dest/specifications
        cat > $dest/specifications/capybara-playwright-driver-0.5.7.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "capybara-playwright-driver"
      s.version = "0.5.7"
      s.summary = "capybara-playwright-driver"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
