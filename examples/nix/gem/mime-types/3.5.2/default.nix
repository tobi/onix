#
# ╔══════════════════════════════════════════════════════════════╗
# ║  GENERATED — do not edit.  Run gemset2nix generate to regen ║
# ╚══════════════════════════════════════════════════════════════╝
#
# mime-types 3.5.2
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
  pname = "mime-types";
  version = "3.5.2";
  src = builtins.path {
    path = ./source;
    name = "mime-types-3.5.2-source";
  };

  dontBuild = true;
  dontConfigure = true;

  passthru = { inherit bundle_path; };

  installPhase = ''
        local dest=$out/${bundle_path}
        mkdir -p $dest/gems/mime-types-3.5.2
        cp -r . $dest/gems/mime-types-3.5.2/
        mkdir -p $dest/specifications
        cat > $dest/specifications/mime-types-3.5.2.gemspec <<'EOF'
    Gem::Specification.new do |s|
      s.name = "mime-types"
      s.version = "3.5.2"
      s.summary = "mime-types"
      s.require_paths = ["lib"]
      s.files = []
    end
    EOF
  '';
}
