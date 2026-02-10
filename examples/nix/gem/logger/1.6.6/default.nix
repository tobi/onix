#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# logger 1.6.6
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
  pname = "logger";
  version = "1.6.6";
  src = builtins.path {
    path = ./source;
    name = "logger-1.6.6-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/logger-1.6.6
        cp -r . $dest/gems/logger-1.6.6/
        mkdir -p $dest/specifications
        cat > $dest/specifications/logger-1.6.6.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "logger"
      s.version = "1.6.6"
      s.summary = "logger"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
