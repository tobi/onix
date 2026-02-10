#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# responders 3.1.1
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
  pname = "responders";
  version = "3.1.1";
  src = builtins.path {
    path = ./source;
    name = "responders-3.1.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/responders-3.1.1
        cp -r . $dest/gems/responders-3.1.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/responders-3.1.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "responders"
      s.version = "3.1.1"
      s.summary = "responders"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
