#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mono_logger 1.1.2
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
  pname = "mono_logger";
  version = "1.1.2";
  src = builtins.path {
    path = ./source;
    name = "mono_logger-1.1.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/mono_logger-1.1.2
        cp -r . $dest/gems/mono_logger-1.1.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mono_logger-1.1.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mono_logger"
      s.version = "1.1.2"
      s.summary = "mono_logger"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
