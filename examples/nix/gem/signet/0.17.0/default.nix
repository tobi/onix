#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# signet 0.17.0
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
  pname = "signet";
  version = "0.17.0";
  src = builtins.path {
    path = ./source;
    name = "signet-0.17.0-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/signet-0.17.0
        cp -r . $dest/gems/signet-0.17.0/
        mkdir -p $dest/specifications
        cat > $dest/specifications/signet-0.17.0.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "signet"
      s.version = "0.17.0"
      s.summary = "signet"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
