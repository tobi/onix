#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run bin/generate to regenerate  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# power_assert 3.0.0
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
  pname = "power_assert";
  version = "3.0.0";
  src = builtins.path {
    path = ./source;
    name = "power_assert-3.0.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/power_assert-3.0.0
        cp -r . $dest/gems/power_assert-3.0.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/power_assert-3.0.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "power_assert"
      s.version = "3.0.0"
      s.summary = "power_assert"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
