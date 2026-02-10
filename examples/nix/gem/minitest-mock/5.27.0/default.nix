#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# minitest-mock 5.27.0
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
  pname = "minitest-mock";
  version = "5.27.0";
  src = builtins.path {
    path = ./source;
    name = "minitest-mock-5.27.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/minitest-mock-5.27.0
        cp -r . $dest/gems/minitest-mock-5.27.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/minitest-mock-5.27.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "minitest-mock"
      s.version = "5.27.0"
      s.summary = "minitest-mock"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
