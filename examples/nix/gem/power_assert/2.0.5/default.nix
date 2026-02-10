#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# power_assert 2.0.5
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
  version = "2.0.5";
  src = builtins.path {
    path = ./source;
    name = "power_assert-2.0.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/power_assert-2.0.5
        cp -r . $dest/gems/power_assert-2.0.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/power_assert-2.0.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "power_assert"
      s.version = "2.0.5"
      s.summary = "power_assert"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
