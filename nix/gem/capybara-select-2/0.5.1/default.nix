#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# capybara-select-2 0.5.1
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
  pname = "capybara-select-2";
  version = "0.5.1";
  src = builtins.path {
    path = ./source;
    name = "capybara-select-2-0.5.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/capybara-select-2-0.5.1
        cp -r . $dest/gems/capybara-select-2-0.5.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/capybara-select-2-0.5.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "capybara-select-2"
      s.version = "0.5.1"
      s.summary = "capybara-select-2"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
