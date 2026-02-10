#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# daemons 1.3.1
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
  pname = "daemons";
  version = "1.3.1";
  src = builtins.path {
    path = ./source;
    name = "daemons-1.3.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/daemons-1.3.1
        cp -r . $dest/gems/daemons-1.3.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/daemons-1.3.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "daemons"
      s.version = "1.3.1"
      s.summary = "daemons"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
