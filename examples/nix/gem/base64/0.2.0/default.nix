#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# base64 0.2.0
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
  pname = "base64";
  version = "0.2.0";
  src = builtins.path {
    path = ./source;
    name = "base64-0.2.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/base64-0.2.0
        cp -r . $dest/gems/base64-0.2.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/base64-0.2.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "base64"
      s.version = "0.2.0"
      s.summary = "base64"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
