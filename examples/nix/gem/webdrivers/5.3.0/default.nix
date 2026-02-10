#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# webdrivers 5.3.0
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
  pname = "webdrivers";
  version = "5.3.0";
  src = builtins.path {
    path = ./source;
    name = "webdrivers-5.3.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/webdrivers-5.3.0
        cp -r . $dest/gems/webdrivers-5.3.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/webdrivers-5.3.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "webdrivers"
      s.version = "5.3.0"
      s.summary = "webdrivers"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
