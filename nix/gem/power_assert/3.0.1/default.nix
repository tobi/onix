#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# power_assert 3.0.1
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
  version = "3.0.1";
  src = builtins.path {
    path = ./source;
    name = "power_assert-3.0.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/power_assert-3.0.1
        cp -r . $dest/gems/power_assert-3.0.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/power_assert-3.0.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "power_assert"
      s.version = "3.0.1"
      s.summary = "power_assert"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
