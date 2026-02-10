#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# linzer 0.7.7
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
  pname = "linzer";
  version = "0.7.7";
  src = builtins.path {
    path = ./source;
    name = "linzer-0.7.7-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/linzer-0.7.7
        cp -r . $dest/gems/linzer-0.7.7/
        mkdir -p $dest/specifications
        cat > $dest/specifications/linzer-0.7.7.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "linzer"
      s.version = "0.7.7"
      s.summary = "linzer"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
