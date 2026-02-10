#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# backports 3.25.1
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
  pname = "backports";
  version = "3.25.1";
  src = builtins.path {
    path = ./source;
    name = "backports-3.25.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/backports-3.25.1
        cp -r . $dest/gems/backports-3.25.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/backports-3.25.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "backports"
      s.version = "3.25.1"
      s.summary = "backports"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
