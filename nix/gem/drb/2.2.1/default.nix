#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix update to regen  ║
# ╚══════════════════════════════════════════════════════════════╝
#
# drb 2.2.1
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
  pname = "drb";
  version = "2.2.1";
  src = builtins.path {
    path = ./source;
    name = "drb-2.2.1-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/drb-2.2.1
        cp -r . $dest/gems/drb-2.2.1/
        mkdir -p $dest/specifications
        cat > $dest/specifications/drb-2.2.1.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "drb"
      s.version = "2.2.1"
      s.summary = "drb"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
