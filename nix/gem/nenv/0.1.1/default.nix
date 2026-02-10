#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# nenv 0.1.1
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
  pname = "nenv";
  version = "0.1.1";
  src = builtins.path {
    path = ./source;
    name = "nenv-0.1.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/nenv-0.1.1
        cp -r . $dest/gems/nenv-0.1.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/nenv-0.1.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "nenv"
      s.version = "0.1.1"
      s.summary = "nenv"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
