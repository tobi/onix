#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# minitest 5.25.5
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
  pname = "minitest";
  version = "5.25.5";
  src = builtins.path {
    path = ./source;
    name = "minitest-5.25.5-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/minitest-5.25.5
        cp -r . $dest/gems/minitest-5.25.5/
        mkdir -p $dest/specifications
        cat > $dest/specifications/minitest-5.25.5.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "minitest"
      s.version = "5.25.5"
      s.summary = "minitest"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
