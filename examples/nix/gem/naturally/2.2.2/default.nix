#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# naturally 2.2.2
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
  pname = "naturally";
  version = "2.2.2";
  src = builtins.path {
    path = ./source;
    name = "naturally-2.2.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/naturally-2.2.2
        cp -r . $dest/gems/naturally-2.2.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/naturally-2.2.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "naturally"
      s.version = "2.2.2"
      s.summary = "naturally"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
